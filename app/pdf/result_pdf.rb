class ResultPdf < Prawn::Document
  def initialize(event, view)
    super(
        top_margin: 72,
        bottom_margin: 72,
        left_margin: 72,
        right_margin: 72,
        page_size: 'LETTER',
        page_layout: :portrait
      )
    @event = event
    @view = view

    generate_letterhead
    generate_date
    generate_subject
    generate_salutation
    generate_body
    generate_closing
  end

  def num_format(num)
    @view.number_to_currency(num, :unit => '')
  end

  def draw_results_table(candidates_with_votes, total_votes)
    row_height = 25
    col_widths = [bounds.width * 0.55, bounds.width * 0.22, bounds.width * 0.23]
    start_y = cursor
    start_x = 0
    
    # Draw header row background
    fill_color "E8E8E8"
    fill_rectangle [start_x, start_y], bounds.width, row_height
    fill_color "000000"
    
    # Draw header text
    bounding_box([start_x + 5, start_y - 5], width: col_widths[0] - 10) do
      text "Candidate Name", size: 10, style: :bold
    end
    bounding_box([start_x + col_widths[0] + 5, start_y - 5], width: col_widths[1] - 10) do
      text "Votes Received", size: 10, style: :bold, align: :center
    end
    bounding_box([start_x + col_widths[0] + col_widths[1] + 5, start_y - 5], width: col_widths[2] - 10) do
      text "Percentage", size: 10, style: :bold, align: :center
    end
    
    # Draw header bottom border
    stroke_horizontal_line start_x, start_x + bounds.width, at: start_y - row_height
    
    current_y = start_y - row_height
    
    # Draw candidate rows
    candidates_with_votes.each_with_index do |(candidate, votes), idx|
      # Highlight winner row
      if idx == 0 && votes > 0
        fill_color "E8F5E9"
        fill_rectangle [start_x, current_y], bounds.width, row_height
        fill_color "000000"
      end
      
      percentage = total_votes > 0 ? (votes.to_f / total_votes * 100).round(2) : 0
      
      # Draw candidate name
      bounding_box([start_x + 5, current_y - 5], width: col_widths[0] - 10) do
        text candidate.name, size: 10
      end
      
      # Draw votes
      bounding_box([start_x + col_widths[0] + 5, current_y - 5], width: col_widths[1] - 10) do
        text votes.to_s, size: 10, align: :center
      end
      
      # Draw percentage
      bounding_box([start_x + col_widths[0] + col_widths[1] + 5, current_y - 5], width: col_widths[2] - 10) do
        text "#{percentage}%", size: 10, align: :center
      end
      
      # Draw row border
      stroke_horizontal_line start_x, start_x + bounds.width, at: current_y - row_height
      current_y -= row_height
    end
    
    # Draw total row background
    fill_color "F0F0F0"
    fill_rectangle [start_x, current_y], bounds.width, row_height
    fill_color "000000"
    
    # Draw total text
    bounding_box([start_x + 5, current_y - 5], width: col_widths[0] - 10) do
      text "TOTAL", size: 10, style: :bold
    end
    bounding_box([start_x + col_widths[0] + 5, current_y - 5], width: col_widths[1] - 10) do
      text total_votes.to_s, size: 10, style: :bold, align: :center
    end
    bounding_box([start_x + col_widths[0] + col_widths[1] + 5, current_y - 5], width: col_widths[2] - 10) do
      text "100%", size: 10, style: :bold, align: :center
    end
    
    # Draw vertical lines
    stroke_vertical_line current_y, start_y, at: start_x
    stroke_vertical_line current_y, start_y, at: start_x + col_widths[0]
    stroke_vertical_line current_y, start_y, at: start_x + col_widths[0] + col_widths[1]
    stroke_vertical_line current_y, start_y, at: start_x + bounds.width
    
    # Draw bottom border
    stroke_horizontal_line start_x, start_x + bounds.width, at: current_y - row_height
    
    # Move cursor below table
    move_cursor_to(current_y - row_height - 10)
  end

  def generate_letterhead
    # Organization/Event Name as Letterhead
    bounding_box([0, cursor], width: bounds.width) do
      text "#{@event.name}", size: 20, style: :bold, align: :center
      text "Election Committee", size: 14, align: :center, color: "666666"
      stroke_horizontal_line 0, bounds.width, at: cursor - 5
    end
    move_down 30
  end

  def generate_date
    # Date aligned to the right
    text "#{DateTime.now.strftime("%B %d, %Y")}", size: 11, align: :right
    move_down 20
  end

  def generate_subject
    # Subject line
    text "SUBJECT: Official Election Results", size: 12, style: :bold
    move_down 15
  end

  def generate_salutation
    text "To Whom It May Concern,", size: 11
    move_down 15
  end

  def generate_body
    # Opening paragraph
    text "This letter serves to officially communicate the results of the #{@event.name} election, which was conducted in accordance with established electoral procedures.", size: 11, align: :justify
    move_down 10
    text "The election results are as follows:", size: 11, style: :bold
    move_down 20

    # Generate results for each position
    @event.positions.each_with_index do |position, index|
      # Position header with background
      fill_color "333333"
      fill_rectangle [0, cursor + 20], bounds.width, 25
      fill_color "000000"
      
      bounding_box([10, cursor + 15], width: bounds.width - 20) do
        text position.name.upcase, size: 12, style: :bold, color: "FFFFFF"
      end
      
      move_down 5

      # Get candidates sorted by vote count (descending) - only count votes with post = true
      candidates_with_votes = position.candidates.map do |candidate|
        [candidate, candidate.votes.where(post: true).count]
      end.sort_by { |_, votes| -votes }

      # Calculate total votes for this position (only votes with post = true)
      total_votes = candidates_with_votes.sum { |_, votes| votes }

      # Create table for results manually
      if candidates_with_votes.any?
        draw_results_table(candidates_with_votes, total_votes)
      else
        text "No candidates or votes recorded for this position.", size: 10, style: :italic, color: "666666"
      end

      move_down 20
      
      # Add page break if needed (except for last position)
      if index < @event.positions.count - 1 && cursor < 150
        start_new_page
        generate_letterhead
        move_down 20
      end
    end

    move_down 20
    
    # Summary paragraph
    total_members = @event.members.count
    voted_members = @event.members.where(voted: true).count
    
    text "Election Summary:", size: 11, style: :bold
    move_down 5
    text "• Total eligible voters: #{total_members}", size: 10
    text "• Total votes cast: #{voted_members}", size: 10
    text "• Voter turnout: #{total_members > 0 ? ((voted_members.to_f / total_members) * 100).round(2) : 0}%", size: 10
    text "• Report generated on: #{DateTime.now.strftime("%B %d, %Y at %I:%M %p")}", size: 10
  end

  def generate_closing
    move_down 30
    
    text "These results have been compiled and verified by the Election Committee. This document serves as the official record of the election results.", size: 11, align: :justify
    move_down 20
    
    text "Respectfully submitted,", size: 11
    move_down 40
    
    # Signature line
    stroke_horizontal_line 0, 200, at: cursor
    move_down 5
    text "1Cooptech Representative", size: 10, style: :italic
    move_down 35
   

    # Signature line
    stroke_horizontal_line 0, 200, at: cursor
    move_down 5
    text "Election Committee Chairperson", size: 10, style: :italic
    move_down 5
    text "#{@event.name}", size: 10, color: "666666"
  end
end 