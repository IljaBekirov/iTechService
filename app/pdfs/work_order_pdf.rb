# encoding: utf-8

class WorkOrderPdf < Prawn::Document
  require "prawn/measurement_extensions"

  def initialize(service_job, view_context)
    super page_size: 'A4', page_layout: :portrait#, margin: 25
    department = service_job.department
    base_font_size = 7
    page_width = 530
    # page_width = 545

    font_families.update 'DroidSans' => {
      normal: "#{Rails.root}/app/assets/fonts/droidsans-webfont.ttf",
      bold: "#{Rails.root}/app/assets/fonts/droidsans-bold-webfont.ttf"
    }

    font 'DroidSans'
    font_size base_font_size

    draw_text "«#{service_job.client.surname.first}»",
              at: [page_width/2-10, cursor-2*base_font_size],
              size: base_font_size*2

    # Logo
    image department.logo_path, fit: [100, 30], at: [20, cursor]

    # Organization info
    organization = Setting.organization(department)

    text "Сервисный центр «#{department.brand_name}» #{organization}", align: :right
    text "Юр. Адрес: #{organization}, #{Setting.legal_address(department)}", align: :right
    text "#{Setting.ogrn_inn(department)}", align: :right

    move_down font_size
    stroke do
      line_width 2
      horizontal_line 0, page_width
    end
    move_down font_size

    text "Фактический адрес: #{Setting.address(department)}", align: :right

    # Contact info
    move_down font_size
    text 'График работы:', align: :right, style: :bold
    text Setting.schedule(department), align: :right
    move_down font_size
    [
      "e-mail: #{Setting.email(department)}",
      "Конт. тел.: #{Setting.contact_phone(department)}",
      "сайт: #{Setting.site(department)}"
    ].each do |str|
      text str, align: :right
    end
    move_up font_size * 6

    # Title
    text "Заказ-наряд № #{service_job.ticket_number}", style: :bold, align: :center
    text "Дата приёма: #{service_job.received_at.strftime('%d.%m.%Y')}", style: :bold, align: :center
    move_down font_size * 2

    # Client info
    text "Клиент: #{service_job.client_full_name} Телефон: #{view_context.number_to_phone service_job.client_phone}"
    text "Адрес: #{service_job.client_address}"
    move_down font_size

    # Table
    device_group = service_job.device_group.presence || /iPhone|iPad|MacBook|iMac|Mac mini/.match(service_job.type_name)
    table [
      ["Торговая марка: #{service_job.trademark}", "imei: #{service_job.imei}"],
      ["Группа изделий: #{device_group}", "Серийный номер: #{service_job.serial_number}"],
      ["Модель: #{service_job.type_name}", "Комплектность: #{service_job.completeness}"],
    ], width: page_width

    table [
            ["Заявленный дефект клиентом", service_job.claimed_defect],
            ["Внешний вид/Состояние устройства", service_job.device_condition],
            ["Комментарии/Особые отметки", service_job.client_comment],
            ["Требование клиента", ''],
            ["Вид работы", service_job.type_of_work],
            ["Ориентировочная стоимость ремонта", service_job.estimated_cost_of_repair]
          ], width: page_width do
      column(0).width = 150
    end

    move_down font_size

    # Text
    text "Клиент ознакомлен и согласен с условиями проведения ремонта:"
    table [
            ['1.', '', {content: "Изделие принимается без детального осмотра и описи (проверки внутренних повреждений) и проверки внутренних неисправностей. Клиент согласен что все неисправности, внутренние и внешние повреждения, не указанные в заказ-наряде, которые могут быть обнаружены в изделии при детальном техническом осмотре специалистом сервисного центра, возникли до приёма изделия в сервисный центр."}],
            ['2.', '', {content: "Сервисный центр не несёт ответственность за потерю информации на устройствах хранения и записи данных, в индивидуальной памяти устройств, связанную с перепрограммированием, заменой блоков памяти, плат, установкой программного обеспечения и т.п.. Рекомендуем сохранять данные, хранящиеся в памяти изделия, на других носителях."}],
            ['3.', '', {content: "Сервисный центр не несёт ответственность за аксессуары установленные на устройстве (защитная плёнка, брелки, декоративные наклейки и т.д.)."}],
            ['4.', '', {content: "Продолжительность платного ремонта при необходимости заказа запасных частей, может составлять до 100 дней."}],
            ['5.', '', {content: "Сервисный центр предоставляет гарантию только на замененные детали в течение 90 дней с момента выдачи аппарата, за исключение работ по ремонту и восстановлению материнской платы. Сервисный центр уведомляет, а клиент принимает к сведению информацию о том, что гарантия на предоставлена исключительно на заменённые детали. Сервисный центр оставляет за собой право отказать в проведении гарантийного ремонта в случае, если в результате проверки аппарата будет установлено, что заявленная неисправность не связана с предыдущим ремонтом (ст 5 п 6 Закона «О защите прав потребителя»)."}],
            ['6.', '', {content: "Клиент обязан забрать изделие не позднее 30 (тридцати) календарных дней со дня уведомления об окончании работ (телефонограммой/заказным письмом), в противном случае клиенту начисляется плата за услуги хранения изделия в размере 5% от стоимости произведенного ремонта за каждый день хранения. При превышении стоимости хранения изделия в сервисном центре над средней рыночной стоимостью самого изделия, такое изделия зачисляется в плату услуг по хранению и возврату клиенту не подлежит."}],
            ['7.', '', {content: "В целях проверки наличия недостатков в ходе диагностики изделия Клиент (потребитель) предупреждён о том, что"}],
            ['-', '', "Настройки изделия будут приведены в состояние, установленное производителем (сброс на заводские установки)."],
            ['-', '', "Оборудование будет проверено на наличие вредоносных программ (так называемых «вирусов»), что может привести к утрате важной для клиента информации."],
            ['-', '', "В связи с требованиями производителей, при поступлении изделия в Сервисный центр обновление программного обеспечения производится как обязательная профилактическая процедура, выполняемая с целью улучшения потребительских свойств изделия и не классифицируется как ремонт."],
            ['8.', '', {content: "Порядок гарантийного обслуживания:"}],
            ['', '', {content: "Гарантийный ремонт оборудования осуществляется согласно условиям, описанным в гарантийном талоне и заказ-наряде. Сервисный центр имеет право не выполнять работы по гарантийному обслуживанию, если в процессе проведения диагностики установит, что неисправность возникла вследствие нарушения пользователем правил использования, повреждения гарантийных стикеров, попытки его вскрытия, а также ремонта лицами не являющимися уполномоченными представителями сервисного центр, нарушение условий хранения или транспортировки оборудования, воздействия на оборудование домашних животных, насекомых, грызунов и посторонних предметов, а также действий непреодолимой силы (пожаров, природной катастрофы и т.д.) и третьих лиц. Сервисный центр уведомляет, а Клиент принимает к сведению информацию о том, что товар не подлежит гарантийному обслуживанию в следующих случаях:"}],
            ['-', '', "обнаружено попадание влаги, жидкости, активных сред на блоки, узлы, платы, отдельные элементы и компоненты устройства - наличие внешних или внутренних механических повреждений устройства"],
            ['-', '', "нарушение либо удаление гарантийной пломбы, а также обнаружение попытки самостоятельного вскрытия или ремонта устройства"],
            ['-', '', "стерт, удалён, либо не читаем серийный номер устройства"],
            ['-', '', "неисправности вызванные использованием не оригинальных устройств или приспособлений (аксессуаров)"],
            ['-', '', "случаи регламентируемые оригинальным гарантийным талоном производителя"],
            ['-', '', "повреждения вызваны воздействием компьютерных вирусов или аналогичных им программ, установки, смены или утраты пароля пользователя (в том числе данных учетных записей iCloud), неквалифицированной модификации и (или) переустановки пользовательского ПО (прошивок), установки и пользования пользовательского ПО и прошивок третьих производителей."],
            ['-', '', "окончание гарантийного срока"],
            ['9.', '', "Сервисный центр оставляет за собой право использовать качественные заводские запасные части устройства которые произведены не только на заводах производителя."],
          ], cell_style: {borders: [], padding: 1} do
      column(0).style width: 10
      column(1).style width: 0
    end

    move_down font_size
    text "С условиями обслуживания и сроками его проведения согласен, правильность заполнения заказа подтверждаю. Сервисный центр оставляет за собой право отказать в проведении гарантийного обслуживания в случае нарушения условий гарантии."
    move_down font_size

    table [
            ["", "_" * 70, "", "_" * 60],
            ["", "«Мною прочитано, возражений не имею»", "", "Подпись"],
            ["", "Аппарат принял: #{service_job&.user&.full_name}", "", "_" * 60],
            ["", "", "", "Подпись приёмщика"],
          ], cell_style: {borders: [], padding: 0} do
      column(0).width = 20
      column(2).width = 40
      row(1).style padding_left: 20
      row(2).style padding_top: 10
      row(3).style padding_left: 20
    end

    move_down font_size
    text "Я, _____________________________________________________________________, даю согласие сервисному центру «#{department.brand_name}» #{organization} на обработку его персональных данных в целях обеспечения соблюдения закона и иных нормативных актов РФ, включая любые действия, предусмотренные Федеральным законом №152-ф3 «О персональных данных». Настоящее соглашение дано, в том числе, для осуществления передачи сервисным центром персональных данных клиента третьим лицам, с которыми у сервисного центра заключены соглашения содержащие условия о конфиденциальности, включая транспортную передачу, а также хранения и обработки оператором и третьими лицами в целях и в сроки, предусмотренные действующим законодательством Российской Федерации. Указание клиентом своего контактного телефона означает его согласие с вышеперечисленными действиями сервисного центра."

    move_down font_size
    table [
            ["", "_" * 70, "", "_" * 60],
            ["", "Фамилия", "", "Подпись"]
          ], cell_style: {borders: [], padding: 0} do
      column(0).width = 20
      column(2).width = 40
      row(1).style padding_left: 20
    end
  end
end