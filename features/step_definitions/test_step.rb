Given(/^I am on the Tweetable login homepage$/) do
  visit login_path
end

Then(/^I should see "(.*?)"$/) do |expectedText|
  expect(page).to have_content(expectedText)
end

Then(/^I should see "(.*?)" passages$/) do |expectedText|
  expect(page).to have_content(expectedText)
end

Then(/^As a candidate user I click on login with Facebook$/) do
  link = '/auth/facebook'
  find("a[href='#{link}']").click
end

Then(/^As an admin user I click on login with Facebook$/) do
  link = '/auth/facebook'
  allow(User).to receive(:is_admin?).with('12345').and_return(true)
  find("a[href='#{link}']").click
end
