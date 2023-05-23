require 'nokogiri'
require 'httparty'

class OpinionScraper

  def update_opinions
    itemscount_added = {opinion: 0, rating: 0, category: 0}
    # Get the page where to find data and parse it
    page = HTTParty.get("https://www.reynaudcharpente.com/avis-clients/")
    parsed_page ||= Nokogiri::HTML(page.body)
    if parsed_page
      parsed_page.css('.pqp-avis').each do |avis|
        # Retrieve text data info
        prestation = avis.css('.pqp-avis-prestation').text.strip
        text = avis.css('.pqp-avis-texte').text.strip
        text_sub = avis.css('.pqp-avis-texte-sub').text.strip
        control = avis.css('.pqp-control-indicator').text.strip
        if !control.empty?
          control = control.split("par")[0]
        end
        # Retrieve detailed notes
        opinion_ratings = {}
        answers = avis.css('.pqp-avis-answer')
        answers.each do |answer|
          answer_text = answer.css('.pqp-avis-answer-text').text.strip
          note = answer.css('.pqp-avis-rating-notes').text.strip.split("/").first
          opinion_ratings[answer_text] = note
        end
        # Retrieve dates and ref info
        footer_data = {}
        footer_letf_items = avis.css('.footer-top').css('.pqp-footer-item')
        footer_letf_items.each do |item|
          item_text = item.text.strip.split(" ")
          footer_data[item_text[0]] = item_text[1]
        end
        footer_right_items = avis.css('.footer-bottom').css('.pqp-footer-item')
        footer_right_items.each do |item|
          item_text = item.text.strip.split(" ")
          footer_data[item_text[0]] = item_text[1]
        end
        realized_at = nil
        filed_at = nil
        published_at = nil
        reference = ""
        footer_data.each do |k, v|
          if k == "Prestation"
            realized_at = Date.parse(v)
          elsif k == "Dépôt"
            filed_at = Date.parse(v)
          elsif k == "Publication"
            published_at = Date.parse(v)
          elsif k == "Référence"
            reference = v 
          end
        end

        # Prepare Opinion params
        opinion_params = { 
          title: prestation,  
          description: text,
          details: text_sub,
          control: control,
          realized_at: realized_at,
          filed_at: filed_at,
          published_at: published_at,
          reference: reference
        }
        # Look if that opinion (reference) already exists
        db_opinion = Opinion.where(["reference = ?", "#{reference}"])
        # Create Opinion only if not yet exists
        if db_opinion.empty?
          db_opinion = Opinion.create(opinion_params)
          itemscount_added[:opinion] += 1
          # Fill up Rating
          opinion_ratings.each do |k, v|
            db_category = Category.where(["name = ?", "#{k}"])
            if db_category.empty?
              db_category = Category.create(name: k)
              itemscount_added[:category] += 1
            else
              db_category = db_category.first
            end
            Rating.create(category_id: db_category.id, opinion_id: db_opinion.id, note: v)
            itemscount_added[:rating] += 1
          end
        end
      end
    end 
    puts itemscount_added
  end
end



