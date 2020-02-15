# NewCkeditor
Short description and motivation.

## Usage
How to use my plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'new_ckeditor'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install new_ckeditor
```

## Output

### Output RAW HTML from CKEditor

To use same CSS as in editor, to keep consistent UI:

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

- different types of ckeditors
- generator for toolbar
- configuration to specify toolbar
- generator for controller?
- store files using active storage
- store with user_id, and parent?
- readme, samples
- gif with demo
- sample with ajax? and with ballon?
- tests
- CSFR-Token
- support inline editor?
- remove title plugin

## Customization

https://ckeditor.com/ckeditor-5/online-builder/

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
