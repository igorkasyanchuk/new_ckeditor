class CkEditorImage < ApplicationRecord
  mount_uploader :file, CkEditorImageUploader

  validates_presence_of :file
end