# Rails + CKEditor 5

Short description and motivation.

## Usage

How to use my plugin.

## Installation

Add this line to your application's Gemfile and run `bundle`:

```ruby
gem 'new_ckeditor'
```

## Configuration

## File Upload with CKEditor 5

Gem doesn't have any strict dependency on any library. It's implemented this way on purpose to let developer use gem which he wants. Maybe in the future we can improve it.

But you can get a base skeleton where you can put your own logic.

Below I'll put an example of code which works with CKEditor.

1. Let's start with new controller `rails g controller file_uploads upload`

```ruby
class FileUploadsController < ApplicationController
  # note
  # that method must return json with URL to an uploaded image
  # or error message
  def upload
    image = CkEditorImage.new(file: params["upload"])
    if image.save
      render json: {
        url: image.file.url
      }
    else
      render json: {
        "error": {
          "message": image.errors.full_messages.join(", ")
        }
      }
    end
  end
end
```

2. Create a new model where images will be stored: `rails g model CkEditorImage file:string user_id:integer parent_id:integer parent_type:string`

```ruby
class CkEditorImage < ApplicationRecord
  mount_uploader :file, CkEditorImageUploader
  belongs_to :user, optional: true
  validates_presence_of :file
end
```

Code of migration may look like:

```ruby
class CreateCkEditorImages < ActiveRecord::Migration[6.0]
  def change
    create_table :ck_editor_images do |t|
      t.string :file
      t.integer :user_id, index: true
      t.integer :parent_id
      t.string :parent_type

      t.datetime :created_at
      t.datetime :updated_at
    end
    add_index :ck_editor_images, :user_id
    add_index :ck_editor_images, [:parent_id, :parent_type]
  end
end
```
Run this migration.

3. Create Carrierwave uploader `rails g uploader CkEditorImage`. Open and edit it if needed.

4. Open again controller, edit logic, check user, check params, etc. You have a full control how to implement logic of storing files.

## CKEditor 5 Toolbar Customization

You can edit in appropriate JS file, for example:

```javascript
    toolbar: {
      items: [
        'heading',
        '|',
        'bold',
        'italic',
        'underline',
        'strikethrough',
        'link',
        'bulletedList',
        'numberedList',
        'alignment',
        '|',
        'indent',
        ...
```

## Output

### Output RAW HTML from CKEditor

To use same CSS as in editor, to keep consistent UI:

Require CSS file in `application.css`:

```css
 *= require new_ckeditor/ckeditor.css
```

And in the view wrap output in `.ck-content` class:

```erb
<p>
  <strong>About:</strong>
  <div class="ck-content">
    <%= raw @user.about %>
  </div>
</p>
```

More documentation: https://ckeditor.com/docs/ckeditor5/latest/builds/guides/integration/content-styles.html

## Styling

### CKEditor 5 set min-height, height, width

```css
.ck-editor__editable {
  min-height: 500px;
}
```

You can editor in some parent div and set height explicitly for editor inside.

## TODO

- configuration to specify toolbar
- generators?
- better and better readme
- gif with demo
- tests
- check how it works with turbolinks?

## Customization

https://ckeditor.com/ckeditor-5/online-builder/

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
