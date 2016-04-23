class PhoneNumberInput < SimpleForm::Inputs::StringInput

  def input(wrapper_options = nil)
    template.content_tag(:div, class: 'input-append input-prepend') do
      template.content_tag(:span, template.icon_tag(:phone), class: 'add-on') +
      @builder.input_field(attribute_name, as: :tel, placeholder: template.t('phone_placeholder').html_safe) +
      template.content_tag(:span, '0', id: 'phone_length', class: 'add-on') +
      template.link_to(template.icon_tag(:ok), '#', id: 'check_phone_number', class: 'btn disabled')
    end.html_safe
  end

end