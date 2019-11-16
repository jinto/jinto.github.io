require 'fileutils'

files = Dir['uploads/uploads/**/*.*']
files.each do |f|
    t = f.gsub("uploads/uploads", "uploads")
    t.gsub!("/","_")
    t = "media/"+t
    if /-\d+x\d+\./.match(f)        # -190x110.jpg 라면?

        # -190x110 을 뺀 원본 파일이 있으면 스킵
        o = f.gsub(/-\d+x\d+\./, ".")
        if(File.exist?(o))
            next
        end
    end
    #puts f+ t+":YES"
    name = /([^\/]+$)/.match(f)
    if system("grep #{name} ../_posts/*md")
        puts f + t+ "YES"
        FileUtils.cp(f, t)
    else
        puts f + "NO"
    end
end
