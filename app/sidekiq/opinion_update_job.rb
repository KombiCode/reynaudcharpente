class OpinionUpdateJob
  include Sidekiq::Job

  def perform(*args)
    opinion_scraper = OpinionScraper.new
    opinion_scraper.update_opinions
  end
end
