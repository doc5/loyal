class Yuedu123::HomeController < Yuedu123Controller
  def index
    @archives_item_fetches = ArchivesItemFetch.all :limit => 20, :order => "created_at desc"
  end
end