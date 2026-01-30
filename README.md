# Nokogiri Web Scraping Learning Repository

A comprehensive collection of Ruby scripts demonstrating web scraping techniques using the Nokogiri gem. This repository provides hands-on examples for parsing HTML/XML documents, navigating the DOM, extracting data, and scraping real websites.

## Overview

Nokogiri is a powerful Ruby gem for parsing and searching XML and HTML documents. This repository contains practical examples that cover everything from basic HTML parsing to advanced web scraping techniques. Whether you're new to web scraping or looking to refine your skills, these examples provide a solid foundation.
![alt text](<image.png>)

## Repository Contents

This repository includes two main practice scripts and comprehensive documentation to help you master Nokogiri.

### nokogiri_examples.rb

A comprehensive tutorial script demonstrating all major Nokogiri features through ten progressive examples. This script is designed to be run from start to finish, building your understanding step by step.

**Key Features:**
- Parsing HTML strings and documents
- CSS selectors (ID, class, nested selectors)
- XPath selectors for complex queries
- DOM traversal techniques (parent, children, siblings)
- Attribute extraction methods
- Text extraction and manipulation
- Pattern matching with regex
- Building HTML with Nokogiri::Builder
- Parsing and navigating XML documents
- Real-world website scraping examples

**Usage:**
```bash
ruby nokogiri_examples.rb
```

### website_scraper.rb

An interactive scraper demonstrating practical techniques across multiple scraper-friendly websites. This script includes a menu system allowing you to practice with different sites individually or all at once.

**Included Practice Sites:**
- **Example.com** - Simple HTML structure for beginners
- **Quotes to Scrape** - Practice extracting quotes, authors, and tags
- **Books to Scrape** - E-commerce site with product listings
- **Hacker News** - Real-world news aggregator

**Usage Options:**
```bash
ruby website_scraper.rb          # Interactive menu
ruby website_scraper.rb 1        # Scrape Example.com
ruby website_scraper.rb 2        # Scrape Quotes to Scrape
ruby website_scraper.rb 3        # Scrape Books to Scrape
ruby website_scraper.rb 4        # Scrape Hacker News
ruby website_scraper.rb 5        # Scrape all sites sequentially
```
## Installation and Setup

**Prerequisites:**
- Ruby installed on your system (version 2.6 or higher recommended)
- Bundler gem (optional but recommended)

**Install Nokogiri:**
```bash
gem install nokogiri
```

**Clone this repository:**
```bash
git clone https://github.com/Elysian0987/nokogiriExplore.git
cd nokogiriExplore
```

**Verify installation:**
```bash
ruby -v                  # Check Ruby version
gem list nokogiri       # Verify Nokogiri is installed
```

## Complete Nokogiri Reference Guide

### CSS Selectors

CSS selectors provide an intuitive way to target elements in HTML documents.

```ruby
# Element selectors
doc.at_css('h1')                    # First <h1> element
doc.css('p')                        # All <p> elements
doc.css('div')                      # All <div> elements

# ID and class selectors
doc.at_css('#my-id')                # Element with id="my-id"
doc.css('.my-class')                # All elements with class="my-class"
doc.at_css('#header')               # Element with id="header"

# Nested selectors
doc.css('div.content p')            # <p> inside <div class="content">
doc.css('ul > li')                  # Direct <li> children of <ul>
doc.css('div p')                    # Any <p> inside any <div>

# Attribute selectors
doc.css('a[href]')                  # Links with href attribute
doc.css('img[alt]')                 # Images with alt text
doc.css('input[type="text"]')       # Text input elements
doc.css('a[href^="https"]')         # Links starting with https

# Pseudo-selectors
doc.css('li:first-child')           # First <li> in its parent
doc.css('li:last-child')            # Last <li> in its parent
doc.css('tr:nth-child(2)')          # Second <tr> element
```

### XPath Selectors

XPath provides powerful querying capabilities for XML and HTML documents.

```ruby
# Basic XPath
doc.xpath('//h1')                   # All <h1> elements anywhere
doc.xpath('//p')                    # All <p> elements
doc.xpath('/html/body/div')         # Specific path from root

# Attribute filtering
doc.xpath('//p[@class="intro"]')    # <p> with class="intro"
doc.xpath('//a[@href]')             # All <a> elements with href
doc.xpath('//div[@id="main"]')      # <div> with id="main"

# Text content filtering
doc.xpath('//p[contains(text(), "important")]')  # <p> containing "important"
doc.xpath('//h1[text()="Welcome"]')              # <h1> with exact text

# Extracting attributes
doc.xpath('//a/@href')              # All href attribute values
doc.xpath('//img/@src')             # All image source URLs
```

### DOM Navigation

Navigate through document structure using parent-child relationships.

```ruby
# Parent and children
element.parent                      # Get parent element
element.children                    # All children (includes text nodes)
element.element_children            # Only element children (no text nodes)

# Siblings
element.next_element                # Next sibling element
element.previous_element            # Previous sibling element
element.next_sibling                # Next sibling (may be text node)

# Ancestors and descendants
element.ancestors                   # All ancestor elements
element.descendants                 # All descendant elements
```

### Data Extraction Methods

Extract content and attributes from elements.

```ruby
# Text extraction
element.text                        # Inner text content (strips HTML)
element.inner_text                  # Same as .text
element.content                     # Text content

# HTML extraction
element.inner_html                  # HTML content inside element
element.to_html                     # Complete HTML including element tags

# Attribute access
element['attribute']                # Get specific attribute value
element['href']                     # Get href attribute
element['class']                    # Get class attribute
element.attributes                  # Hash of all attributes
element.attribute('data-id')        # Alternative attribute access

# Checking attributes
element.has_attribute?('href')      # Check if attribute exists
element.classes                     # Array of CSS classes
```

## Learning Path

Follow this recommended learning path to build your Nokogiri skills progressively.

**Step 1: Run the comprehensive tutorial**
```bash
ruby nokogiri_examples.rb
```
Read through the output carefully and examine the code for each example. This will give you a solid foundation in all major Nokogiri features.

**Step 2: Experiment with individual websites**
```bash
ruby website_scraper.rb 2    # Start with the Quotes site
```
Try modifying the selectors to extract different elements or additional data.

**Step 3: Explore browser DevTools**
Open the practice websites in your browser, right-click on elements, and select "Inspect" to understand their HTML structure. This is crucial for writing accurate selectors.

**Step 4: Modify existing scripts**
Edit the scripts to extract different data points. For example:
- Extract quote tags from the Quotes site
- Get book availability from the Books site
- Extract comment counts from Hacker News

**Step 5: Practice with new websites**
Apply your knowledge to other scraper-friendly websites. Always check robots.txt and terms of service first.

## Best Practices for Web Scraping

### Ethical Scraping Guidelines

**Respect robots.txt**
Always check a website's robots.txt file (e.g., https://example.com/robots.txt) to see which paths are allowed for scraping.

**Use appropriate User-Agent headers**
Identify your scraper with a realistic User-Agent string, as demonstrated in the scripts.

**Implement rate limiting**
Add delays between requests to avoid overwhelming servers:
```ruby
require 'net/http'
sleep(1)  # Wait 1 second between requests
```

**Prefer APIs when available**
Many websites offer official APIs that are more reliable and ethical than scraping.

**Handle errors gracefully**
Always wrap scraping code in begin-rescue blocks to handle network errors and parsing issues.

**Cache responses**
Save scraped data locally to avoid redundant requests during development.

### Technical Best Practices

**Validate your selectors**
Test selectors in the browser console before implementing them in code.

**Handle missing elements**
Use conditional checks to prevent errors when elements don't exist:
```ruby
title = doc.at_css('h1')&.text || 'No title found'
```

**Clean extracted data**
Strip whitespace and normalize text:
```ruby
text = element.text.strip.gsub(/\s+/, ' ')
```

**Parse dates and numbers properly**
Convert strings to appropriate data types for analysis.

## Practice Sites

These websites are specifically designed for learning web scraping.

**Quotes to Scrape**
- URL: http://quotes.toscrape.com/
- Features: Quotes with authors and tags, pagination, login forms
- Safe for unlimited practice without blocking

**Books to Scrape**
- URL: http://books.toscrape.com/
- Features: Product listings, ratings, prices, categories
- Excellent for e-commerce scraping practice

**Example.com**
- URL: https://example.com/
- Features: Simple, stable HTML structure
- Perfect for beginners

## Common Issues and Solutions

**Issue: "cannot load such file -- nokogiri"**

Solution: Install the Nokogiri gem
```bash
gem install nokogiri
```

**Issue: Empty results from CSS selector**

Solutions:
- Verify HTML structure using browser DevTools
- Check if JavaScript is required to load content (Nokogiri cannot execute JavaScript)
- Try using XPath instead of CSS selectors
- Ensure the element exists on the page

**Issue: Website blocking requests**

Solutions:
- Verify User-Agent header is set correctly
- Add delays between requests
- Use the practice sites which never block
- Consider if the site requires JavaScript rendering (use tools like Selenium for dynamic sites)

**Issue: SSL certificate errors**

Solution: Update OpenSSL or use:
```ruby
URI.open(url, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE)
```

**Issue: Encoding problems with special characters**

Solution: Specify encoding explicitly:
```ruby
html.force_encoding('UTF-8')
```

## Additional Resources

**Official Documentation:**
- [Nokogiri Official Documentation](https://nokogiri.org/)
- [Nokogiri Tutorials](https://nokogiri.org/tutorials/)

**Selector References:**
- [CSS Selectors Reference](https://www.w3schools.com/cssref/css_selectors.php)
- [XPath Tutorial](https://www.w3schools.com/xml/xpath_intro.asp)
- [MDN CSS Selectors Guide](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Selectors)

**Ruby Resources:**
- [Ruby Documentation](https://ruby-doc.org/)
- [Ruby Style Guide](https://rubystyle.guide/)

## Advanced Topics

Once you've mastered the basics, explore these advanced topics:

**Handling pagination**
Scrape multiple pages by following next-page links or incrementing URL parameters.

**Authentication and sessions**
Use cookies and session tokens to scrape login-protected content.

**Parallel scraping**
Use Ruby threads or concurrent-ruby gem to scrape multiple pages simultaneously.

**Data storage**
Store scraped data in CSV, JSON, or databases (SQLite, PostgreSQL, etc.).

**Handling dynamic content**
For JavaScript-heavy sites, consider using Selenium WebDriver or Watir.

**API integration**
Combine scraping with API calls for comprehensive data collection.

## Contributing

Contributions are welcome. If you have additional examples or improvements:

- Fork the repository
- Create a feature branch
- Add your examples with clear documentation
- Submit a pull request

## License

This project is open source and available for educational purposes. When scraping websites, always respect their terms of service and robots.txt files.

## Acknowledgments

- Practice sites provided by scrapethissite.com and toscrape.com
- Nokogiri gem maintained by the Ruby community
- Examples inspired by common web scraping use cases

## Contact

For questions or feedback, please open an issue on GitHub.

Happy scraping!