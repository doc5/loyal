# -*- encoding : utf-8 -*-
require 'rubygems'  
require 'rmmseg'  
require 'rmmseg/ferret'

ActsAsFerret.logger.level = Logger::ERROR

_default_shared_options_remote = true
_default_shared_options_ferret ||=  {:analyzer => RMMSeg::Ferret::Analyzer.new}

#_default_shared_options_ferret ||=  {:analyzer => Ferret::Analysis::PerFieldAnalyzer.new}
_default_shared_options_fields = {
  :categories => {:store => :yes, :index => :untokenized, :boost => 25, :via => :shared_searcher_categories},               
  :created_by => {:store => :yes, :boost => 35, :via => :shared_searcher_created_by},            
  :title => {:store => :yes, :boost => 50, :via => :shared_searcher_title},
  :content => {:boost=> 30,
    :store => :yes,
    :term_vector => :with_positions_offsets, 
    :via => :shared_searcher_content},
  :outline => {:boost=> 30,
    :store => :yes,
    :term_vector => :with_positions_offsets, 
    :via => :shared_searcher_outline},
  :created_at => {:index => :untokenized, :store => :yes, :via => :shared_searcher_created_at},
  :updated_at => {:index => :untokenized, :store => :yes, :via => :shared_searcher_updated_at}
}
#_default_shared_options_if = Proc.new { |entity| (defined?(entity.do_index?) || true) }

#ActsAsFerret::rebuild_index 'shared'

ActsAsFerret::define_index('shared',
  :models => {    
    ArchivesItemFetch => {
      :fields => _default_shared_options_fields,
      :remote => _default_shared_options_remote
    }, 
    ArchivesItem => {
      :fields => _default_shared_options_fields,
      :remote => _default_shared_options_remote
    }
  },
#  :if => _default_shared_options_if,
  :ferret => _default_shared_options_ferret
)