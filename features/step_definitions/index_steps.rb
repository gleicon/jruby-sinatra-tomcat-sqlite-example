Given /^I visit the "(.+)" page$/ do |url|
	  visit(url)
end

Then /^I see "(.*)" text$/ do |text|
	  response_body.should contain(/#{text}/m)
end

