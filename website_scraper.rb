require 'nokogiri'
require 'open-uri'

# Real browser User-Agent to avoid being blocked
USER_AGENT = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36"

# ============================================================================
# Website Scraper - Practice scraping different sites
# ============================================================================

def scrape_example_com
  puts "\n" + "="*70
  puts "Scraping Example.com"
  puts "="*70
  
  url = "https://example.com"
  html = URI.open(url, "User-Agent" => USER_AGENT).read
  doc = Nokogiri::HTML(html)
  
  # Extract title
  title = doc.at_css('title').text
  puts "Page Title: #{title}"
  
  # Extract h1
  h1 = doc.at_css('h1')
  puts "Main Heading: #{h1.text}" if h1
  
  # Extract all paragraphs
  paragraphs = doc.css('p')
  puts "\nParagraphs found: #{paragraphs.length}"
  paragraphs.each_with_index do |p, i|
    puts "  P#{i + 1}: #{p.text[0..60]}..."
  end
  
  # Extract links
  links = doc.css('a')
  puts "\nLinks found: #{links.length}"
  links.each do |link|
    text = link.text
    href = link['href']
    puts "  - #{text}: #{href}"
  end
end

def scrape_quotes
  puts "\n" + "="*70
  puts "Scraping Quotes to Scrape (http://quotes.toscrape.com)"
  puts "="*70
  
  begin
    url = "http://quotes.toscrape.com/"
    html = URI.open(url, "User-Agent" => USER_AGENT).read
    doc = Nokogiri::HTML(html)
    
    # Extract quotes
    quotes = doc.css('.quote')
    puts "Found #{quotes.length} quotes:\n\n"
    
    quotes.first(5).each_with_index do |quote, i|
      text = quote.at_css('.text').text
      author = quote.at_css('.author').text
      tags = quote.css('.tag').map(&:text)
      
      puts "#{i + 1}. #{text}"
      puts "   - #{author}"
      puts "   - Tags: #{tags.join(', ')}"
      puts
    end
    
  rescue => e
    puts "Error: #{e.message}"
  end
end

def scrape_books
  puts "\n" + "="*70
  puts "Scraping Books to Scrape (http://books.toscrape.com)"
  puts "="*70
  
  begin
    url = "http://books.toscrape.com/"
    html = URI.open(url, "User-Agent" => USER_AGENT).read
    doc = Nokogiri::HTML(html)
    
    # Extract books
    books = doc.css('article.product_pod')
    puts "Found #{books.length} books:\n\n"
    
    books.first(10).each_with_index do |book, i|
      title = book.at_css('h3 a')['title']
      price = book.at_css('.price_color').text
      rating = book.at_css('.star-rating')['class'].split.last
      
      puts "#{i + 1}. #{title}"
      puts "   - Price: #{price}"
      puts "   - Rating: #{rating}"
    end
    
  rescue => e
    puts "Error: #{e.message}"
  end
end

def scrape_hacker_news
  puts "\n" + "="*70
  puts "Scraping Hacker News (https://news.ycombinator.com)"
  puts "="*70
  
  begin
    url = "https://news.ycombinator.com/"
    html = URI.open(url, "User-Agent" => USER_AGENT).read
    doc = Nokogiri::HTML(html)
    
    # Get story titles
    stories = doc.css('.titleline > a').first(10)
    
    puts "Top 10 stories:\n\n"
    stories.each_with_index do |story, i|
      title = story.text
      link = story['href']
      
      # Make relative URLs absolute
      link = "https://news.ycombinator.com/#{link}" unless link.start_with?('http')
      
      puts "#{i + 1}. #{title}"
      puts "   #{link[0..70]}#{'...' if link.length > 70}"
    end
    
  rescue => e
    puts "Error: #{e.message}"
  end
end

# ============================================================================
# Main Menu
# ============================================================================

if __FILE__ == $0
  puts "="*70
  puts "WEBSITE SCRAPER - Choose a site to scrape"
  puts "="*70
  puts "\n1. Example.com (simple HTML)"
  puts "2. Quotes to Scrape (practice site)"
  puts "3. Books to Scrape (practice site)"
  puts "4. Hacker News (real site)"
  puts "5. All of the above"
  puts "\nEnter choice (1-5): "
  
  choice = ARGV[0] || gets.chomp
  
  case choice
  when "1"
    scrape_example_com
  when "2"
    scrape_quotes
  when "3"
    scrape_books
  when "4"
    scrape_hacker_news
  when "5"
    scrape_example_com
    scrape_quotes
    scrape_books
    scrape_hacker_news
  else
    puts "Invalid choice. Running all examples..."
    scrape_example_com
    scrape_quotes
    scrape_books
    scrape_hacker_news
  end
  
  puts "\n" + "="*70
  puts "Done! Try modifying the selectors to extract different data."
  puts "="*70
end
