# create files in `_posts` from wordpress export file
# category, tag, images, video, embed, comments, trackback
# redirector for "idx: #{idx}"
require 'nokogiri'
require 'date'
require 'string_helpers'
include StringHelpers

xml = Nokogiri::XML(File.read("export.xml"))

def gen_slug(ymd, title)
    _slug = title.slug!
    _slug.sub!('/', '_')
    ymd = ymd + '-' if ymd.length() > 0
    return ymd + _slug + ".md"
end

def write(f, str)

    puts str
    f.write str + "\n"
end

xml.xpath("//wp:cat_name").each do |category|
    name = category.inner_text
    File.open("category/"+name.slug!+".md", 'w') { |f| 
        write f, "---"
        write f, "layout: category"
        write f, "title: #{name}"
        write f, "category: #{name.slug!}"
        write f, "---"
    }
end

xml.xpath("//channel/item").each do |post|
	type = post.at('wp|post_type').inner_text
    status = post.at('wp|status').inner_text
    if type == 'post' and status == 'publish'
        pubDate = DateTime.parse(post.at('pubDate'))
        idx = post.at('wp|post_id').inner_text
        title = post.at('title').inner_text.strip()
        strYMD = pubDate.strftime("%Y-%m-%d")
        slug = gen_slug(strYMD, title)
        categories = []
        tags = []
        post.xpath("category").each { |category|
            text = category.inner_text
            p text
            if category.attribute('domain').value == 'category'
                categories << text.slug!()
            else
                tags << text.slug!()
            end
        }

        puts "create file " + slug
        File.open("_posts/"+slug, 'w') { |f| 
            write f, "---"
            write f, "layout: post"
            write f, "title: #{title}"
            write f, "date: #{pubDate}"
            write f, "categories: #{categories.join(' ')}" if categories.length() > 0
            write f, "tags: #{tags.join(' ')}"if tags.length() > 0
            write f, "---"
            write f, post.at('content|encoded').inner_text.strip()
        }
    end
end
