
echo 'print $stdin.read.reverse' | ruby does_it_say_no.rb
# -> no

echo 'if $stdin.read.include?("no") then print "no" end' | ruby does_it_say_no.rb
# -> yes
