TEMPLATE = <<EOF
---
title: "@title"
date: 2022-1-3T10:00:00+08:00
draft: false
---
EOF
def add_header(fp)
  puts fp
  lines = File.readlines(fp)
  # low priority
  header = lines[0]
  lines.each do |l|
    # most priority
    if /^#\s/.match?(l)
      header = l[2..].chomp
      break
    end
  end
  tmp = TEMPLATE.gsub("@title", header)
  contents = tmp + lines.join("\n")
  File.write(fp, contents, mode: "w")
end
def mod_header(fp)
  puts fp
  lines = File.readlines(fp)
  new_lines = []
  # low priority
  header = lines[0]
  header_flg = false
  lines.each do |l|
    # most priority
    if /^---/.match?(l)
      header_flg = !header_flg
    end
    if header_flg && /^date:/.match?(l)
      new_lines << "date: 2022-01-03\n"
      next
    end
    new_lines << l
  end
  File.write(fp, new_lines.join, mode: "w")
end
["tec_memo", "memo"].each do |root|
  Dir.glob("./#{root}/**/*.md").each do |fp|
    begin
      mod_header(fp)
    rescue => e
      p e
    end

  end
end
# mod_header("test.md")
