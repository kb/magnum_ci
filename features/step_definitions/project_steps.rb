Then /^(?:|I )remove the "([^\"]*)" build directory$/ do |project|
  FileUtils.rm_rf("#{RAILS_ROOT}/builds/#{project}")
end
