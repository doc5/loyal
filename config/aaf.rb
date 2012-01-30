# -*- encoding : utf-8 -*-
require 'rubygems'  
require 'rmmseg'  
require 'rmmseg/ferret'

_default_shared_options_ferret ||=  {:analyzer => RMMSeg::Ferret::Analyzer.new}
_default_shared_options_fields = {
  :categories => {:store => :yes, :index => :untokenized, :boost => 5, :via => :shared_searcher_categories},               
  :created_by => {:store => :yes, :boost => 5, :via => :shared_searcher_created_by},            
  :title => {:store => :yes, :boost => 30, :via => :shared_searcher_title},
  :content => {:boost=> 40,
    :store => :yes,
    :term_vector => :with_positions_offsets, 
    :via => :shared_searcher_content},
  :created_at => {:index => :untokenized, :store => :yes, :via => :shared_searcher_created_at},
  :updated_at => {:index => :untokenized, :store => :yes, :via => :shared_searcher_updated_at}
}
_default_shared_options_if = Proc.new { |entity| (defined?(entity.do_index?) || true) }

ActsAsFerret::define_index('shared',
  :models => {    
    ArchivesItemFetch => {
      :fields => _default_shared_options_fields
    }, 
    ArchivesItem => {
      :fields => _default_shared_options_fields
    }
  },
  :if => _default_shared_options_if,
  :ferret => _default_shared_options_ferret
)