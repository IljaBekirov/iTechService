module ProductGroupsHelper

  def root_product_groups
    ProductGroup.roots
  end

  def product_group_root
    ProductGroup.roots.first
  end

  def product_groups_trees_tag(product_groups, opened=[], current_id=nil, options={})
    product_groups.map do |product_group|
      product_groups_tree_tag product_group, opened, current_id, options
    end.join.html_safe
  end

  def product_groups_tree_tag(product_group, opened=[], current_id=nil, options={})
    content_tag(:ul, nested_product_groups_list(product_group.subtree.arrange, opened, current_id, options), class: 'product_groups_tree unstyled', id: "product_groups_tree_#{product_group.id}", data: {root_id: product_group.id, product_group_id: @current_product_group_id, opened: @opened_product_groups})
  end

  def nested_product_groups_list(product_groups, opened=[], current_id=nil, options={})
    opened ||= []
    product_groups.map do |product_group, sub_product_groups|
      is_current = product_group.id == current_id
      li_class = (opened.include?(product_group.id)) ? 'opened' : 'closed'
      li_class << ' current' if is_current
      content_tag(:li, link_to(product_group.name, product_group_path(product_group, options), remote: true) + content_tag(:ul, nested_product_groups_list(sub_product_groups, opened, current_id, options)), class: "product_group #{li_class}", id: "product_group_#{product_group.id}", title: product_group.name, data: {product_group_id: product_group.id, products: product_items(product_group.products)})
      #content_tag(:li, link_to(product_group.name, products_path(options.merge(group: product_group.id)), remote: true) + content_tag(:ul, nested_product_groups_list(sub_product_groups, opened, current_id, options)), class: "product_group #{li_class}", id: "product_group_#{product_group.id}", title: product_group.name, data: {product_group_id: product_group.id, products: product_items(product_group.products)})
    end.join.html_safe
  end

end
