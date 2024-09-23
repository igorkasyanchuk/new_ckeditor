# Rails + CKEditor 5

[![RailsJazz](https://github.com/igorkasyanchuk/rails_time_travel/blob/main/docs/my_other.svg?raw=true)](https://www.railsjazz.com)
[![https://www.patreon.com/igorkasyanchuk](https://github.com/igorkasyanchuk/rails_time_travel/blob/main/docs/patron.svg?raw=true)](https://www.patreon.com/igorkasyanchuk)
[![Listed on OpenSource-Heroes.com](https://opensource-heroes.com/badge-v1.svg)](https://opensource-heroes.com/r/igorkasyanchuk/new_ckeditor)

DEMO is available inside dummy app inside gem source code.

Simple way to integrate Ruby on Rails application with CKEditor 5. This is the latest version of CKEditor which has more modern UI and cool toolbars. Main features:

- Inline editor
- Balloon editor
- Classic editor
- File uploads (custom controller & uploader)
- Tables, Media, and other toolbar buttons
- (requires maybe 10-15 minutes to configure gem, but works fine, better to clone and check source of demo)

![Demo](/docs/new_ckeditor.png)
[>> Demo site](https://new-ckeditor-demo.herokuapp.com/)

## Usage

```
1. Add gem
2. bundle
3. rails g new_ckeditor # to generate toolbars & configs
4. add js in application.js, or to the assets pipeline
5. in your form
  # to load CKEditor JS
  = javascript_include_tag 'new_ckeditor/classic/ckeditor', 'data-turbolinks-track': 'reload'
  
  # form control
  = f.ckeditor :description
```

### Inline/Balloon

For inline/balloon editor you need to define a saver function, example is: [app.js](https://github.com/igorkasyanchuk/new_ckeditor_demo/blob/master/app/assets/javascripts/app.js)

```erb
  <p>
    <%= ckeditor_tag :content, @post.content, editor: { template: :balloon, type: :balloon, js: "sendData('#{update_inline_post_path(@post)}', editorHiddenField.value)" } %>
  </p>
```

Options:

- teamplte - file with configuration for CKEditor, toolbar, path to upload files, etc
- type - type of editor, depending on the type behavior is a little different. Balloon and inline editors works almost the same way. Classic works better as form field. 
  
### File uploads

Define logic for saving file (controller/uploader).

Sample: https://github.com/igorkasyanchuk/new_ckeditor_demo/blob/master/app/controllers/posts_controller.rb#L10-L23

You need also to configure your CKEditor editor config, sample: https://github.com/igorkasyanchuk/new_ckeditor_demo/blob/master/app/views/new_ckeditor/shared/_inline.html.erb#L50-L54

You need to define path to which send file and also CSRF token for security purposes. You can see how it works in example above.

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

You can create a copy of each `classic`, `balloon`', `inline` .js file and use. Or even creae custom build on `ckeditor.com` site and put in your app.

After that you can specify which exactly editor type and template with toolbar configuration to use:

```erb
<%= form.ckeditor :description, editor: { template: :inline, type: :inline } %>
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
- fix issue fix JS map files
- easier configuration
- saver function to save inline/balloon editor

## Customization

https://ckeditor.com/ckeditor-5/online-builder/

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

[<img src="https://github.com/igorkasyanchuk/rails_time_travel/blob/main/docs/more_gems.png?raw=true"
/>](https://www.railsjazz.com/?utm_source=github&utm_medium=bottom&utm_campaign=new_ckeditor)
