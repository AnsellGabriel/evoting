require 'pagy/extras/countless'
require 'pagy/extras/bootstrap'
require 'pagy/extras/overflow'

# default :empty_page (other options :last_page and :exception )
Pagy::DEFAULT[:overflow] = :last_page