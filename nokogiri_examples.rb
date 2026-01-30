require 'nokogiri'
require 'open-uri'

# ============================================================================
# NOKOGIRI EXPLORATION - Interactive Menu Edition
# ============================================================================

def colorize(text, color_code)
  "\e[#{color_code}m#{text}\e[0m"
end

def cyan(text); colorize(text, 36); end
def green(text); colorize(text, 32); end
def yellow(text); colorize(text, 33); end
def red(text); colorize(text, 31); end
def magenta(text); colorize(text, 35); end
def bold(text); colorize(text, 1); end
def blue(text); colorize(text, 34); end

# Sample HTML for examples
def sample_html
  <<-HTML
<!DOCTYPE html>
<html>
  <head><title>My Page</title></head>
  <body>
    <h1 id="main-heading">Welcome</h1>
    <div class="content">
      <p class="intro">This is a paragraph.</p>
      <p class="highlight">Important text here!</p>
      <ul id="my-list">
        <li>Item 1</li>
        <li>Item 2</li>
        <li>Item 3</li>
      </ul>
    </div>
  </body>
</html>
HTML
end

# ----------------------------------------------------------------------------
# Example 1: Parsing HTML String
# ----------------------------------------------------------------------------
def example_1
  puts
  puts green("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
  puts yellow("[1] Parsing HTML String - The Foundation")
  puts green("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")

  doc = Nokogiri::HTML(sample_html)

  puts cyan("\nDocument parsed successfully! Now extracting content...")
  puts
  puts "Title: " + bold(doc.at_css('title').text)
  puts "H1 content: " + bold(doc.at_css('h1').text)
  puts "First paragraph: " + bold(doc.at_css('p').text)
  puts
end

# ----------------------------------------------------------------------------
# Example 2: CSS Selectors
# ----------------------------------------------------------------------------
def example_2
  puts
  puts green("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
  puts yellow("[2] CSS Selectors - Targeting Elements")
  puts green("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")

  doc = Nokogiri::HTML(sample_html)

  # Find by ID
  heading = doc.at_css('#main-heading')
  puts "\nBy ID (#main-heading): " + cyan(heading.text)

  # Find by class
  intro = doc.at_css('.intro')
  puts "By class (.intro): " + cyan(intro.text)

  # Find all elements with a class
  all_paragraphs = doc.css('p')
  puts "\nAll <p> tags: " + magenta("#{all_paragraphs.length} found")
  all_paragraphs.each_with_index do |p, i|
    puts "   #{i + 1}. #{p.text}"
  end

  # Nested selector
  list_items = doc.css('#my-list li')
  puts "\nList items: " + cyan(list_items.map(&:text).join(', '))
  puts
end

# ----------------------------------------------------------------------------
# Example 3: XPath Selectors
# ----------------------------------------------------------------------------
def example_3
  puts
  puts green("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
  puts yellow("[3] XPath Selectors - Advanced Navigation")
  puts green("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")

  doc = Nokogiri::HTML(sample_html)

  # XPath examples
  title_xpath = doc.xpath('//title').text
  puts "\nTitle via XPath: " + cyan(title_xpath)

  # Find elements with specific attribute
  paragraphs_xpath = doc.xpath('//p[@class="highlight"]')
  puts "Highlighted paragraphs: " + yellow(paragraphs_xpath.first.text)
  puts
end

# ----------------------------------------------------------------------------
# Example 4: Traversing the DOM
# ----------------------------------------------------------------------------
def example_4
  puts
  puts green("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
  puts yellow("[4] DOM Traversal - Navigating the Tree")
  puts green("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")

  doc = Nokogiri::HTML(sample_html)
  div = doc.at_css('.content')
  
  puts "\nParent: " + cyan("<#{div.parent.name}>")
  puts "Children count: " + magenta(div.children.length.to_s)
  puts "Element children: " + magenta(div.element_children.length.to_s)

  first_p = doc.at_css('p')
  puts "Next sibling: " + cyan(first_p.next_element.text)
  puts
end

# ----------------------------------------------------------------------------
# Example 5: Extracting Attributes
# ----------------------------------------------------------------------------
def example_5
  puts
  puts green("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
  puts yellow("[5] Extracting Attributes - Accessing Element Data")
  puts green("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")

  doc = Nokogiri::HTML(sample_html)
  heading = doc.at_css('h1')
  
  puts "\nH1 id attribute: " + cyan(heading['id'])
  puts "H1 attributes: " + yellow(heading.attributes.keys.join(', '))

  list = doc.at_css('ul')
  puts "UL id: " + cyan(list['id'])
  puts
end

# ----------------------------------------------------------------------------
# Example 6: Scraping a Real Website (Hacker News)
# ----------------------------------------------------------------------------
def example_6
  puts
  puts green("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
  puts yellow("[6] Scraping Real Website - Hacker News")
  puts green("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
  puts cyan("\nFetching live data from the internet...")

  begin
    url = "https://news.ycombinator.com/"
    html = URI.open(url, "User-Agent" => "Ruby/Nokogiri Tutorial").read
    hn_doc = Nokogiri::HTML(html)
    
    # Get top 5 story titles
    stories = hn_doc.css('.titleline > a').first(5)
    
    puts green("\nTop 5 Stories:")
    puts
    stories.each_with_index do |story, i|
      title = story.text
      link = story['href']
      puts bold("  #{i + 1}. ") + magenta(title)
      puts "     Link: " + cyan(link)
      puts
    end
  rescue => e
    puts red("Error fetching Hacker News: #{e.message}")
  end
  puts
end

# ----------------------------------------------------------------------------
# Example 7: Text Extraction and Manipulation
# ----------------------------------------------------------------------------
def example_7
  puts
  puts green("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
  puts yellow("[7] Text Extraction - Getting Content")
  puts green("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")

  doc = Nokogiri::HTML(sample_html)
  div = doc.at_css('.content')
  
  puts "\nInner text: " + cyan(div.text.strip)
  puts "Inner HTML preview: " + yellow(div.inner_html[0..50] + "...")
  puts
end

# ----------------------------------------------------------------------------
# Example 8: Searching with Regex
# ----------------------------------------------------------------------------
def example_8
  puts
  puts green("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
  puts yellow("[8] Searching with Patterns - Text Matching")
  puts green("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")

  doc = Nokogiri::HTML(sample_html)
  
  puts "\nSearching for the word 'important'...\n"
  doc.css('p').each do |p|
    if p.text.match?(/important/i)
      puts "Found: " + cyan(p.text)
    end
  end
  puts
end

# ----------------------------------------------------------------------------
# Example 9: Building HTML with Nokogiri::Builder
# ----------------------------------------------------------------------------
def example_9
  puts
  puts green("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
  puts yellow("[9] Building HTML - Creating Documents")
  puts green("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")

  builder = Nokogiri::HTML::Builder.new do |html|
    html.html {
      html.head {
        html.title "Generated Page"
      }
      html.body {
        html.h1("Generated Heading", class: "main")
        html.p("This was created with Nokogiri::Builder")
        html.ul {
          ['Ruby', 'Python', 'JavaScript'].each do |lang|
            html.li(lang)
          end
        }
      }
    }
  end

  puts "\nGenerated HTML preview:"
  puts yellow(builder.to_html[0..200] + "...")
  puts
end

# ----------------------------------------------------------------------------
# Example 10: Parsing XML
# ----------------------------------------------------------------------------
def example_10
  puts
  puts green("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
  puts yellow("[10] Parsing XML - Working with XML Documents")
  puts green("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")

  xml_string = <<-XML
<?xml version="1.0"?>
<bookstore>
  <book category="fiction">
    <title>Harry Potter</title>
    <author>J.K. Rowling</author>
    <price>29.99</price>
  </book>
  <book category="tech">
    <title>Ruby Programming</title>
    <author>David Flanagan</author>
    <price>39.99</price>
  </book>
</bookstore>
XML

  xml_doc = Nokogiri::XML(xml_string)
  books = xml_doc.xpath('//book')
  
  puts "\nBooks found: " + magenta(books.length.to_s)
  puts

  books.each do |book|
    title = book.at_xpath('title').text
    author = book.at_xpath('author').text
    price = book.at_xpath('price').text
    category = book['category']
    
    puts "  " + bold(title) + cyan(" by #{author}")
    puts "     Price: $#{price} | Category: #{category}"
    puts
  end
end

# ----------------------------------------------------------------------------
# Run All Examples
# ----------------------------------------------------------------------------
def run_all
  example_1
  example_2
  example_3
  example_4
  example_5
  example_6
  example_7
  example_8
  example_9
  example_10
  
  puts green("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
  puts cyan("\nAll examples completed successfully.\n")
end

# ----------------------------------------------------------------------------
# Display Menu
# ----------------------------------------------------------------------------
def display_menu
  puts
  puts cyan("╔══════════════════════════════════════════════════════════════════╗")
  puts cyan("║") + bold("        NOKOGIRI INTERACTIVE EXAMPLES                          ") + cyan("║")
  puts cyan("║") + "           Choose an example to run                           " + cyan("║")
  puts cyan("╚══════════════════════════════════════════════════════════════════╝")
  puts
  puts blue("  ┌────────────────────────────────────────────────────────────┐")
  puts blue("  │") + "  MAIN MENU - Available Examples:                       " + blue("│")
  puts blue("  ├────────────────────────────────────────────────────────────┤")
  puts blue("  │") + "                                                         " + blue("│")
  puts blue("  │") + "    #{green('1)')} Parsing HTML String                            " + blue("│")
  puts blue("  │") + "    #{green('2)')} CSS Selectors                                  " + blue("│")
  puts blue("  │") + "    #{green('3)')} XPath Selectors                                " + blue("│")
  puts blue("  │") + "    #{green('4)')} DOM Traversal                                  " + blue("│")
  puts blue("  │") + "    #{green('5)')} Extracting Attributes                          " + blue("│")
  puts blue("  │") + "    #{green('6)')} Scraping Real Website (Hacker News)           " + blue("│")
  puts blue("  │") + "    #{green('7)')} Text Extraction                                " + blue("│")
  puts blue("  │") + "    #{green('8)')} Searching with Patterns                        " + blue("│")
  puts blue("  │") + "    #{green('9)')} Building HTML                                  " + blue("│")
  puts blue("  │") + "    #{green('10)')} Parsing XML                                   " + blue("│")
  puts blue("  │") + "                                                         " + blue("│")
  puts blue("  │") + "    #{yellow('11)')} Run ALL Examples (Full Tutorial)             " + blue("│")
  puts blue("  │") + "    #{red('0)')} Exit                                          " + blue("│")
  puts blue("  │") + "                                                         " + blue("│")
  puts blue("  └────────────────────────────────────────────────────────────┘")
  puts
  print cyan("  Enter your choice (0-11): ")
end

# ----------------------------------------------------------------------------
# Main Program Loop
# ----------------------------------------------------------------------------
def main
  loop do
    display_menu
    choice = gets.chomp
    
    case choice
    when "1"
      example_1
    when "2"
      example_2
    when "3"
      example_3
    when "4"
      example_4
    when "5"
      example_5
    when "6"
      example_6
    when "7"
      example_7
    when "8"
      example_8
    when "9"
      example_9
    when "10"
      example_10
    when "11"
      run_all
    when "0"
      puts
      puts cyan("╔══════════════════════════════════════════════════════════════════╗")
      puts cyan("║") + bold("   Thank you for using Nokogiri Interactive Examples!    ") + cyan("║")
      puts cyan("╚══════════════════════════════════════════════════════════════════╝")
      puts
      break
    else
      puts red("\nInvalid choice! Please enter a number between 0 and 11.\n")
      sleep(1.5)
    end
    
    unless choice == "0"
      puts
      print yellow("Press Enter to return to menu...")
      gets
    end
  end
end

# Run the program
if __FILE__ == $0
  main
end
