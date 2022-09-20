require 'application_system_test_case'

class PublicPagesTest < ApplicationSystemTestCase
  setup do
    @public_page = public_pages(:one)
  end

  test 'visiting the index' do
    visit public_pages_url
    assert_selector 'h1', text: 'Public pages'
  end

  test 'should create public page' do
    visit public_pages_url
    click_on 'New public page'

    click_on 'Create Public page'

    assert_text 'Public page was successfully created'
    click_on 'Back'
  end

  test 'should update Public page' do
    visit public_page_url(@public_page)
    click_on 'Edit this public page', match: :first

    click_on 'Update Public page'

    assert_text 'Public page was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Public page' do
    visit public_page_url(@public_page)
    click_on 'Destroy this public page', match: :first

    assert_text 'Public page was successfully destroyed'
  end
end
