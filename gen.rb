# create files in `_posts` from wordpress export file
# tag, images, video, embed, comments, trackback
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

def write(f, str, ends="\n")

    #puts str
    f.write str + ends
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
xml.xpath("//wp:tag_name").each do |tag|
    name = tag.inner_text
    File.open("tag/"+name.slug!+".md", 'w') { |f| 
        write f, "---"
        write f, "layout: tag"
        write f, "title: #{name}"
        write f, "tag: #{name.slug!}"
        write f, "---"
    }
end

xml.xpath("//channel/item").each do |post|
	type = post.at('wp|post_type').inner_text
    status = post.at('wp|status').inner_text
    if type == 'post' and status == 'publish'
        pubDate = DateTime.parse(post.at('pubDate'))
        idx = post.at('wp|post_id').inner_text

        #next if idx.to_i <= 200
        #next if idx.to_i >= 1000

        title = post.at('title').inner_text.strip()
        strYMD = pubDate.strftime("%Y-%m-%d")
        slug = gen_slug(strYMD, title)
        categories = []
        tags = []
        post.xpath("category").each { |category|
            text = category.inner_text
            if category.attribute('domain').value == 'category'
                categories << text.slug!()
            else
                tags << text.slug!()
            end
        }
        body = post.at('content|encoded').inner_text.strip()
        lines = []
        body.gsub!("<br />", "\n")
        body.gsub!(/alt="[^"]*"/, " ")
        body.gsub!(" width=99%", " ")
        body.gsub!(/ style="[^"]*"/," ")
        body.gsub!(/target=pic/, " ")
        body.gsub!(/border="[^"]*"/, " ")
        body.gsub!(/width="[^"]*"/, " ")
        body.gsub!(/height="[^"]*"/, " ")
        body.gsub!(/class="[^"]*"/, " ")
        body.gsub!(/hspace="\d+"[ ]\/>/,">\n")
        body.gsub!(/hspace=\d+[ ]\/>/,">\n")
        body.gsub!(/hspace=\d+[ ]>/,">\n")
        body.gsub!(/data-block="true" data-editor="d9meq"/,"")
        body.gsub!(/<!-- wp:image {"\w+":\d+} -->/,'')
        body.gsub!(/<!-- \/wp:image -->/,'')
        body.gsub!(/<figure\s\s+>/,'')
        body.gsub!(/<\/figure[ ]>/,'')

        body.gsub!("</p><p>", "\n")
        body.gsub!("</p>", "\n")
        body.gsub!("<BR>", "\n")
        body.gsub!("<br>", "\n")
        body.gsub!("<br/>", "\n")
        body.gsub!("<center>", "\n")
        body.gsub!(/ data-offset-key="\w+"/,"")
        body.gsub!("</center>", "\n")
        body.gsub!("<p >", "\n")
        body.gsub!(/<p align="\w+">/, "")
        body.gsub!("<p>", "\n")
        body.gsub!('  ', ' ')
        body.gsub!('  ', ' ')
        body.squeeze!(' ')
        body.each_line do |line|
            #do something with line
            line = line.strip()
            localimg = line.scan(/^<a href="http:\/\/jinto.pe.kr\/wp-content\/uploads.*><img.*><\/a>$/)
            localimg2 = line.scan(/^<a href="http:\/\/jinto.pe.kr\/.*><img.*><\/a>$/)
            limg3 = line.scan(/^<img src="http:\/\/jinto.pe.kr\/wp-content\/uploads.*>$/)
            localimg4 = line.scan(/^<img src=\/photo.*>$/)
            limg5 = line.scan(/^<img src="http:\/\/jinto.pe.kr\/photo.*>$/)
            limg51= line.scan(/^<img src=http:\/\/jinto.pe.kr\/photo.*>$/)
            limg6 = line.scan(/^<img src="http:\/\/jinto.pe.kr\/logs\/.*>$/)
            limg61 = line.scan(/^<a href="\/logs\/.*<img.*>.*>$/)
            limg7 = line.scan(/^<img src=\/logs.*>$/)
            lhref1 = line.scan(/^<a src=\/logs.*>$/)

            if localimg.length() > 0 || 
               localimg2.length() > 0 || 
               limg3.length() > 0 || 
               localimg4.length() > 0 ||
               limg5.length() > 0 ||
               limg51.length() > 0 ||
               limg6.length() > 0 ||
               limg61.length() > 0 ||
               limg7.length() > 0
                puts line
            end
            if localimg.length() > 0
                src = /src="(.*?)"/.match(line)[1]
                src.gsub!("http://jinto.pe.kr/wp-content/","")
                src.gsub!("/","_")
                line = "![ ](/assets/media/#{src})"
            elsif localimg2.length() > 0
                src = /src="(.*?)"/.match(line)[1]
                src.gsub!("http://jinto.pe.kr/wp-content/","")
                src.gsub!("/","_")
                line = "![ ](/assets/media/#{src})"
            elsif limg3.length() > 0
                src = /src="(.*?)"/.match(line)[1]
                src.gsub!("http://jinto.pe.kr/wp-content/","")
                src.gsub!("/","_")
                line = "![ ](/assets/media/#{src})"
            elsif localimg4.length() > 0
                src = /src=\/(.*?)[ >]/.match(line)[1]
                src.gsub!("/","_")
                line = "![ ](/assets/media/#{src})"
            elsif limg5.length() > 0
                src = /src="(.*?)"/.match(line)[1]
                src.gsub!("http://jinto.pe.kr/","")
                src.gsub!("/","_")
                line = "![ ](/assets/media/#{src})"
            elsif limg51.length() > 0
                src = /src=(.*?)[ >]/.match(line)[1]
                src.gsub!("http://jinto.pe.kr/","")
                src.gsub!("/","_")
                line = "![ ](/assets/media/#{src})"
            elsif (limg6.length() > 0 || limg61.length() > 0)
                src = /src="(.*?)"/.match(line)[1]
                src.gsub!("http://jinto.pe.kr/","")
                src.gsub!("/","_")
                line = "![ ](/assets/media/#{src})"
            elsif limg7.length() > 0
                src = /src=\/(.*?)[ >]/.match(line)[1]
                src.gsub!("/","_")
                line = "![ ](/assets/media/#{src})"
            end

            lines << line

            if localimg.length() > 0 || 
               localimg2.length() > 0 || 
               limg3.length() > 0 || 
               localimg4.length() > 0 ||
               limg5.length() > 0 ||
               limg51.length() > 0 ||
               limg6.length() > 0 ||
               limg61.length() > 0 ||
               limg7.length() > 0
                puts line
            end
        end
        #return if idx=="40"
        body = lines.join("\n")
        body.gsub!("<!-- wp:paragraph -->", "")
        body.gsub!("<!-- /wp:paragraph -->", "")
        body.gsub!("</blockquote>", "\n\n")
        body.gsub!("<blockquote>", "\n\n> ")
        body.gsub!(/<div[^>]*>|<\/div>/, "\n\n")
        body.gsub!(/<span[^>]*>|<\/span>/, "")
        body.gsub!(/<a href="http:\/\/jinto.pe.kr\/logs\/archives\/[0]*(\d+).html"/,
                   "<a href=\"/\\1\\2\"")
        body.gsub!("&nbsp;", " ")
        body.gsub!("  ", " ")
        body.gsub!("\n\n", "\n")
        body.gsub!("\n\n", "\n")
        body.gsub!("\n\n", "\n")
        body.gsub!("\n\n", "\n")
        body.gsub!("\n", "\n\n")

        puts "create file " + slug
        File.open("_posts/"+slug, 'w') { |f| 
            write f, "---"
            write f, "layout: post"
            write f, "title: #{title}"
            write f, "date: #{pubDate}"
            write f, "categories: #{categories.join(' ')}" if categories.length() > 0
            write f, "tags: #{tags}"if tags.length() > 0
            write f, "redirect_from:"
            write f, "  - /#{idx}"
            write f, "---"
            write f, ""
            write f, body

#$* * *
### 댓글 ###
#<!--- cmt:6 --->
#<!--- mail:susemi99@gmail.com --->
#<!--- parent:0 --->
#<small>쎄미 : 고맙습니다~ <small>(2015-02-05 01:51:31)</small></small>
#
#<!--- cmt:7 --->
#<!--- mail: --->
#<!--- parent:0 --->
#<!-- ping:7 --->
#<small>쎄미 | [rails] PostgreSQL의 한글 필드 정렬 : <a href='http://susemi99.kr/2558'> [&#8230;] http://tech.jinto.pe.kr/165 에서 해답을 얻었다. [&#8230;] </a> <small>(2015-02-05 01:58:58)</small></small>
            comments  = post.xpath('wp:comment')
            if comments.size() > 0
                write f, "\n* * *\n"
                write f, "### 댓글\n\n"
                post.xpath('wp:comment').each { |cmt|
                    if cmt.at('wp|comment_approved').inner_text == "1" 

                        author = cmt.at('wp|comment_author').inner_text
                        cdate =  cmt.at('wp|comment_date').inner_text
                        email = cmt.at('wp|comment_author_email').inner_text
                        parent =  cmt.at('wp|comment_parent')
                        content = cmt.at('wp|comment_content').inner_text

                        write f, "\n<!--- cmt:" + cmt.at('wp|comment_id')+" --->"
                        write f, "<!--- mail:" + email+ " --->"
                        write f, "<!--- parent:"+parent+" --->"

                        write f, "\n<small class=comment>"+author + " : ", ""

                        if cmt.at('wp|comment_type').inner_text == 'pingback' ||
                           cmt.at('wp|comment_type').inner_text == 'trackback'
                            write f, "<!-- ping:"+cmt.at('wp|comment_id')+" --->", ""
                            url = cmt.at('wp|comment_author_url').inner_text
                            write f, " (Trackback from <a href='#{url}'>#{url}</a>) ", ""
                        end

                        write f, content.gsub("\n"," "), ""
                        write f, " <small>(" +cdate+ ")</small></small>\n"
                    end
                }
            end
        }
    end
end
