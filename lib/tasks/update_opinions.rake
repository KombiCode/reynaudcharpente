
desc "Trigger web scraper to update opinions data from PQP site"
task :update_opinions => :environment do
  OpinionScraper.new.update_opinions
end