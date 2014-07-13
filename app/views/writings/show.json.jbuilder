json.(@writing, :id, :title, :content, :category_id, :private)
json.category_name @writing.category_name.blank? ? 'Not categorized' : @writing.category_name
