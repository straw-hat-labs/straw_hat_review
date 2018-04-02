defmodule StrawHat.Review.Test.AttachmentsTest do
  use StrawHat.Review.Test.DataCase, async: true
  alias StrawHat.Review.Attachments

  describe "find_attachment/1" do
    test "with valid id" do
      attachment = insert(:attachment)

      assert {:ok, _attachment} = Attachments.find_attachment(attachment.id)
    end

    test "with invalid id shouldn't find the attachment" do
      assert {:error, _reason} = Attachments.find_attachment(8347)
    end
  end

  test "get_attachments/1 list the attachments per page" do
    insert_list(10, :attachment)
    attachment = Attachments.get_attachments(%{page: 2, page_size: 5})

    assert length(attachment.entries) == 5
  end

  test "create_attachment/1 with valid inputs creates a attachment" do
    review = insert(:review)
    params = params_for(:attachment, review: review)

    assert {:ok, _attachment} = Attachments.create_attachment(params)
  end

  test "update_attachment/2 with valid inputs updates a attachment" do
    attachment = insert(:attachment)
    {:ok, attachment} = Attachments.update_attachment(attachment, %{content_type: "text/html"})

    assert attachment.content_type == "text/html"
  end

  test "destroy_attachment/1 with a found review destroys the attachment" do
    attachment = insert(:attachment)

    assert {:ok, _} = Attachments.destroy_attachment(attachment)
  end
end
