require 'spec_helper'

describe ArchivesItemFetch do
#  pending "add some examples to (or delete) #{__FILE__}"
  it "uuid not null" do
    item_fetch = FactoryGirl.create(:archives_item_fetch)
    item_fetch.uuid.should_not be_nil  
  end
  
  
  
end
