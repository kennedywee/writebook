require "test_helper"

class PicturesControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in :kevin
  end

  test "update picture" do
    get edit_leafable_path(leaves(:reading_picture))
    assert_response :ok

    put leafable_path(leaves(:reading_picture)), params: {
      leaf: { title: "New picture" },
      picture: {
        image: fixture_file_upload("white-rabbit.webp", "image/webp")
      } }

    assert_response :no_content

    updated_picture = Picture.last
    assert_equal "New picture", updated_picture.title
    assert_equal "white-rabbit.webp", updated_picture.image.filename.to_s
  end

  test "update caption" do
    get edit_leafable_path(leaves(:reading_picture))
    assert_response :ok

    put leafable_path(leaves(:reading_picture)), params: {
      picture: {
        caption: "New caption"
      } }

    assert_response :no_content

    updated_picture = Picture.last

    assert_equal "New caption", updated_picture.caption
    assert_equal "reading.webp", updated_picture.image.filename.to_s
  end
end
