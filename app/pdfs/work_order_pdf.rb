# encoding: utf-8

class WorkOrderPdf < Prawn::Document
  require "prawn/measurement_extensions"

  def initialize(service_job, view_context)
    super page_size: 'A4', page_layout: :portrait
    service_job
    base_font_size = 7

    font_families.update 'DroidSans' => {
      normal: "#{Rails.root}/app/assets/fonts/droidsans-webfont.ttf",
      bold: "#{Rails.root}/app/assets/fonts/droidsans-bold-webfont.ttf"
    }

    font 'DroidSans'
    font_size base_font_size

    # Logo
    move_down font_size *
    stroke do
      line_width 2
      horizontal_line 0, 530
    end
    move_up 40
    image File.join(Rails.root, 'app/assets/images/logo.jpg'), width: 80, at: [20, cursor]

    # TODO: Barcode

    # Organization info
    move_down font_size
    text "Юр. Адрес: ИП Колесник В. В., г. Владивосток, ул. Шилкинская д. 3-1", align: :right
    text "ОГРН: #{Setting.ogrn}", align: :right
    text "Фактический адрес: г. Владивосток, ул. Океанский пр-т, д. 90", align: :right
    text "ул. Семёновская, д. 34", align: :right

    # Contact info
    move_down font_size * 2
    bounding_box [400, cursor], width: 130 do
      text 'График работы:', align: :right, style: :bold
      text Setting.schedule, align: :right
      move_down font_size
      [
        'e-mail: info@itechstore.ru',
        'тел.: +7 (423)2-672-673',
        'тел.: +7 (423)2-673-672',
        'сайт: http://itechstore.ru'
      ].each do |str|
        text str, align: :right
      end
    end
    move_up font_size * 6

    # Title
    text "Заказ-наряд № #{service_job.ticket_number}", style: :bold, align: :center
    text "Дата приёма: #{service_job.received_at.localtime.strftime('%d.%m.%Y')}", style: :bold, align: :center
    move_down font_size * 2

    # Client info
    text "Заказчик: #{service_job.client_full_name} Телефон: #{view_context.number_to_phone service_job.client_phone}"
    text "Адрес: #{service_job.client_address}"
    move_down font_size

    # Table
    device_group = /iPhone|iPad|MacBook|iMac|Mac mini/.match service_job.type_name
    table [
      ["Торговая марка: Apple", "imei: #{service_job.imei}"],
      ["Группа изделий: #{device_group}", "Серийный номер: #{service_job.serial_number}"],
      ["Модель: #{service_job.type_name}", "Комплектность: аппарат"],
    ], width: 530

    table [
            ["Заявленный дефект клиентом", service_job.claimed_defect],
            ["Внешний вид/Состояние телефона", service_job.device_condition],
            ["Комментарии/Особые отметки", service_job.client_comment]
          ], width: 530 do
      column(0).width = 150
    end

    move_down font_size

    # Text
    text "Клиент ознакомлен и согласен с условиями проведения ремонта:"
    table [
            ["1.", {content: "Изделие принимается без детального осмотра и описи (проверки внутренних повреждений) и проверки внутренних неисправностей. Клиент согласен что все неисправности, внутренние и внешние повреждения, не указанные в заказ-наряде, которые могут быть обнаружены в изделии при детальном техническом осмотре специалистом сервисного центра, возникли до приёма изделия в сервисный центр.", colspan: 2}],
            [{content: "", colspan: 3}],
            ["", "_" * 70, "_" * 60],
            ["", {content: "«Мною прочитано, возражений не имею»", padding_left: 20}, "подпись"],
            [{content: "", colspan: 3}],
            ["2.", {content: "ИП Колесник В. В. «iTech» не несёт ответственность за потерю информации на устройствах хранения и записи данных, в индивидуальной памяти устройств, связанную с перепрограммированием, заменой блоков памяти, плат, установкой программного обеспечения и т.п.. Рекомендуем сохранять данные, хранящиеся в памяти изделия, на других носителях.", colspan: 2}],
            ["3.", {content: "ИП Колесник В. В. «iTech» не несёт ответственность за аксессуары (защитная плёнка, брелки, декоративные наклейки и т.д.).", colspan: 2}],
            ["4.", {content: "Продолжительность платного ремонта при необходимости заказа запасных частей, может составлять до 100 дней.", colspan: 2}],
            ["5.", {content: "ИП Колесник В. В. «iTech» предоставляет гарантию на выполненные платные работы в течение 90 дней с момента выдачи аппарата.", colspan: 2}],
            ["6.", {content: "ИП Колесник В. В. «iTech» уведомляет, а Клиент принимает к сведению информацию о том, что гарантия на выполненные платные работы предоставлена исключительно на выполненную работу и заменённые детали. Сервисный центр оставляет за собой право отказать в проведении гарантийного ремонта в случае, если в результате проверки аппарата будет установлено, что заявленная неисправность не связана с предыдущим ремонтом (ст 5 п 6 Закона «О защите прав потребителя»).", colspan: 2}],
            ["7.", {content: "Клиент обязан забрать изделие не позднее 30 (тридцати) календарных дней со дня уведомления об окончании работ (телефонограмма/заказное письмо), в противном случае Клиенту начисляется оплата за услуги хранения изделия в размере 5% от его стоимости за каждый день хранения. При превышении стоимости хранения изделия над стоимостью самого изделия, такое изделия зачисляется в оплату услуг по хранению и возврату Клиенту не подлежит.", colspan: 2}],
          ], cell_style: {borders: [], padding: 1} do
      column(0).style padding_left: 0, padding_right: 10
      column(1).style padding_left: 0
      column(2).style width: 20
      row(1).style height: (base_font_size * 3)
      row(3).columns(1..2).style padding_left: 20, padding_bottom: 10
    end

    text "Условия проведения диагностики"
    text "В целях проверки наличия недостатков в ходе диагностики изделия Клиент предупреждён о том, что"

    table [
            ["-", "Настройки изделия будут приведены в состояние, установленное производителем (сброс на заводские установки)."],
            ["-", "Оборудование будет проверено на наличие вредоносных программ (так называемых «вирусов»), что может привести к утрате важной для потребителя информации."],
            ["-", "В связи с требованиями производителей, при поступлении изделия в Сервисный центр обновление программного обеспечения производится как обязательная профилактическая процедура, выполняемая с целью улучшения потребительских свойств изделия и не классифицируется как ремонт."]
          ], cell_style: {borders: [], padding: 1} do
      column(0).style padding_left: 10, padding_right: 10
    end

    text "Порядок гарантийного обслуживания"
    text "Гарантийный ремонт оборудования осуществляется согласно условиям, описанным в гарантийном талоне."
    text "Сервисный центр имеет право не выполнять работы по гарантийному обслуживанию, если в процессе проведения диагностики установит, что неисправность возникла вследствие нарушения пользователем правил использования, повреждения гарантийных стикеров, попытки его вскрытия, а также ремонта лицами не являющимися уполномоченными представителями СЦ, нарушение условий хранения или транспортировки оборудования, воздействия на оборудование домашних животных, насекомых, грызунов и посторонних предметов, а также действий непреодолимой силы (пожаров, природной катастрофы и т.д.)."
    text "ИП Колесник В. В. «iTech» уведомляет, а Клиент принимает к сведению информацию о том, что товар не подлежит гарантийному обслуживанию в следующих случаях"
    table [
            ["-", "обнаружено попадание влаги, жидкости, активных сред на блоки, узлы, платы, отдельные элементы и компоненты устройства"],
            ["-", "наличие внешних или внутренних механических повреждений устройства"],
            ["-", "нарушение либо удаление гарантийной пломбы, а также обнаружение попытки самостоятельного вскрытия или ремонта устройства"],
            ["-", "стерт, удалён, либо не читаем серийный номер устройства"],
            ["-", "неисправности вызванные использованием не оригинальных устройств или приспособлений (аксессуаров)"],
            ["-", "случаи регламентируемые оригинальным гарантийным талоном производителя"],
            ["-", "повреждения вызваны воздействием компьютерных вирусов или аналогичных им программ, установки или смены пароля, неквалифицированной модификации и (или) переустановки пользовательского ПО (прошивок), установки и пользования пользовательского ПО и прошивок третьих производителей"]
          ], cell_style: {borders: [], padding: 1} do
      column(0).style padding_left: 10, padding_right: 10
    end

    text "При периодическом характере заявленной неисправности началом работы по её устранению считается день её выполнения в период проведения диагностики специалистами ИП Колесник В. В. «iTech»"
    move_down font_size * 2

    table [
            [{content: "Клиент даёт согласие ИП Колесник В. В. «iTech» на обработку его персональных данных в целях обеспечения соблюдения закона и иных нормативных актов РФ, включая любые действия, предусмотренные Федеральным законом №152-ф3 «О персональных данных». Настоящее соглашение дано, в том числе, для осуществления передачи сервисным центром персональных данных клиента третьим лицам, с которыми у сервисного центра заключены соглашения содержащие условия о конфиденциальности, включая транспортную передачу, а также хранения и обработки оператором и третьими лицами в целях и в сроки, предусмотренные
действующим законодательством Российской Федерации. Указание клиентом своего контактного телефона означает его согласие с вышеперечисленными действиями сервисного центра", colspan: 2}],
            ["Аппарат принял: #{service_job&.user&.full_name}", {content: "С условиями обслуживания и сроками его проведения согласен, правильность заполнения заказа подтверждаю. ИП Колесник В. В. «iTech» оставляет за собой право отказать в проведении гарантийного обслуживания в случае нарушения условий гарантии", rowspan: 2}],
            [""],
            ["Подпись приёмщика ______________________________", "Подпись заказчика ______________________________"]
          ] do
      columns(0..1).width = 250
      row(1).column(1).borders = [:left, :right]
      row(2).column(0).borders = [:left]
      row(3).columns(0..1).borders = %i[left right bottom]
    end
  end
end