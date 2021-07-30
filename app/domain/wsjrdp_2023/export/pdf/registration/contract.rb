# frozen_string_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_wsjrdp_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_wsjrdp_2023.
require 'prawn/qrcode'
require 'digest'

module Wsjrdp2023
  module Export::Pdf::Registration
    class Contract < Section
      include FinanceHelper

      # rubocop:disable Metrics/AbcSize,Metrics/MethodLength,Metrics/CyclomaticComplexity
      def render
        pdf.bounding_box [pdf.bounds.left, pdf.bounds.top], width: pdf.bounds.width do
          qrcode = RQRCode::QRCode.new(qrcode_content, level: :h, size: 10)
          pdf.render_qr_code(qrcode, dot: 1.5)
        end
        pdf.y = bounds.height - 60
        bounding_box([0, 230.mm], width: bounds.width, height: bounds.height - 200) do
          font_size(8) do
            text list, style: :italic, width: bounds.width
          end
        end
      end

      def list
        of_legal_age = @person.years.to_i >= 18

        if of_legal_age
          signature = pdf.make_table([
                                       [{ content: @person.town + ' den ' \
                                        + Time.zone.today.strftime('%d.%m.%Y'), height: 30 }],
                                       ['______________________________', ''],
                                       [{ content: @person.full_name, height: 30 }, '']
                                     ],
                                     cell_style: { width: 240, padding: 1, border_width: 0,
                                                   inline_format: true })
        elsif @person.additional_contact_single
          signature = pdf.make_table([
                                       [{ content: @person.town + ' den ' \
                                         + Time.zone.today.strftime('%d.%m.%Y'), height: 30 }],
                                       %w(__________________________ __________________________),
                                       [{ content: @person.additional_contact_name_a, height: 30 },\
                                        + @person.full_name]
                                     ],
                                     cell_style: { width: 240, padding: 1, border_width: 0,
                                                   inline_format: true })
        else
          signature = pdf.make_table([
                                       [{ content: @person.town + ' den ' \
                                         + Time.zone.today.strftime('%d.%m.%Y'), height: 30 }],
                                       %w(__________________________ __________________________),
                                       [{ content: @person.additional_contact_name_a, height: 30 },\
                                        + @person.additional_contact_name_b],
                                       ['______________________________', ''],
                                       [{ content: @person.full_name, height: 30 }, '']
                                     ],
                                     cell_style: { width: 240, padding: 1, border_width: 0,
                                                   inline_format: true })
        end

        if Rails.env.development?
          text qrcode_content
        end

        pdf.move_down 3.mm
        text 'Was muss ich mit der Anmeldung machen?', size: 12
        text 'Die Anmeldung muss'
        text '1. vollständig unterschrieben werden'
        text '2. auf anmeldung.worldscoutjamboree.de unter '\
        + '"Upload>Anmeldung hochladen" hochgeladen werden'
        text '3. am ersten Treffen der entsprechenden Betreuungsperson im Orginal überreicht werden'
        pdf.move_down 3.mm
        pdf.stroke_horizontal_rule

        pdf.move_down 3.mm
        text 'Anmeldung', size: 12

        text 'von ' + @person.full_name + ', geboren am ' + @person.birthday.strftime('%d.%m.%Y') \
        + ', wohnhaft in ' + @person.address + ', ' + @person.zip_code + ', ' + @person.town
        text 'beim Ring deutscher Pfadfinder*innenverbände e.V (rdp) Chausseestraße 128/129,'\
        + ' 10115 Berlin.'
        text ' für das deutsche Kontingent zum 25. World Scout Jamboree 2023 in Südkorea.'

        pdf.move_down 3.mm
        text "Die Teilnahme, als #{role_full_name(@person.role_wish)}, "\
        + " im deutschen Kontingent kostet #{payment_value(@person.role_wish)} und"\
        " beinhaltet #{package(@person.role_wish)}."
        text 'Die Reise ist für den Zeitraum vom 20.07 bis 21.08.2023'\
        +' geplant. Der Reisezeitraum variiert je nach gewähltem Paket und Lage der'\
        +" Sommerferien, Reisedauer sind #{package_time(@person.role_wish)}."

        pdf.move_down 3.mm
        text 'Hiermit ' + (of_legal_age ? 'melde ich mich ' : 'melden wir unser Kind ') \
        + @person.full_name + ', geboren am ' + @person.birthday.strftime('%d.%m.%Y') \
        + " verbindlich mit dem Paket #{role_full_name(@person.role_wish)}" \
        + ' zur Teilnahme im Deutschen Kontingent'\
        + ' zum 25. World Scout Jamboree 2023 an. Mit der Anmeldung '\
        + (of_legal_age ? 'akzeptiere ich' : 'akzeptieren wir')\
        + ' die Reisebedingungen, die vom rdp als Veranstalter vorgegeben werden.'\

        pdf.move_down 3.mm
        text 'Der rdp behält sich das Recht vor, angekündigte Programminhalte durch'\
        +' andere zu ersetzen und notwendige Änderungen des Programms unter Wahrung'\
        +' des Gesamtcharakters der Veranstaltung vorzunehmen.'

        pdf.move_down 3.mm
        text 'Es besteht die Möglichkeit, dass der Veranstalter des Jamboree in Korea'\
        +' ergänzende Bedingungen für die Teilnahme stellt und/oder weitere Daten'\
        +' abfragt. Der rdp muss diese ergänzenden Bedingungen an alle Teilnehmer*innen'\
        +' weitergeben, obwohl er auf den Inhalt keinen Einfluss hat, weil sonst'\
        +' eine Teilnahme nicht möglich ist. Die Teilnehmer*innen werden über diese Änderungen'\
        +' in Textform unterrichtet. Sollte der Teilnehmer*innen mit diesen ergänzenden Bedingungen'\
        +' nicht einverstanden sein, kann er nach Maßgabe von 8. der Reisebedingungen zu'\
        +' diesem Vertrag zurücktreten. '

        pdf.move_down 3.mm
        unless of_legal_age
          text 'Für die Dauer der Reise übertragen wir die Ausübung der Aufsichtspflicht und das'\
          + ' Aufenthaltsbestimmungsrecht über unser Kind dem Reiseveranstalter. Wir sind damit'\
          + ' einverstanden, dass die Ausübung im erforderlichen Ausmaß auf volljährige'\
          + ' Betreuer*innen übertragen wird.'
          pdf.move_down 3.mm
        end

        pdf.move_down 3.mm

        text 'Als Bestandteil dieser Anmeldung haben wir folgende Dokumente in der Anlage'\
          + ' zur Kenntnis genommen:'
        text '- die Teilnahme- und Reisebedingungen des rdp (v0.3 vom 28.07.2021)'
        text '- die Datenschutzhinweise (v0.3 vom 28.07.2021)'
        text 'Die Dokumente stehen auch unter www.worldscoutjamboree.de/downloads'\
        +' zur Verfügung.'
        pdf.move_down 3.mm

        text 'Den Medizinbogen und das SEPA-Mandat im Anhang'\
          + (of_legal_age ? ' habe ich ' : ' haben wir ') + 'gesondert unterschrieben.'
        pdf.move_down 3.mm

        pdf.move_down 3.mm
        signature.draw


        pdf.start_new_page
        pdf.move_down 3.mm
        text 'Was muss ich mit dem SEPA-Mandat machen?', size: 12
        text 'Das SEPA-Mandat muss'
        text '1. vollständig unterschrieben werden'
        text '2. auf anmeldung.worldscoutjamboree.de unter "Upload>SEPA hochladen" hochgeladen'\
        + ' werden'
        text '3. am ersten Treffen der entsprechenden Betreuungsperson im Orginal überreicht werden'
        pdf.move_down 3.mm
        pdf.stroke_horizontal_rule
        pdf.move_down 3.mm

        text 'SEPA-Mandat', size: 12
        text 'Die Raten zur Teilnahme am Jamboree werden mittels SEPA-Basislastschrift eingezogen:'
        pdf.move_down 2.mm
        text 'Ich ermächtige den Ring deutscher Pfadfinder*innenverbände e.V., die Zahlungen '\
        + 'gemäß Zahlungsplan von meinem Konto mittels Lastschrift einzuziehen. Zugleich weise '\
        + 'ich mein Kreditinstitut an, die vom Ring deutscher Pfadfinder*innenverbände '\
        + 'e.V. auf mein Konto gezogenen Lastschriften einzulösen.'
        pdf.move_down 2.mm
        text 'Hinweis: Ich kann innerhalb von acht Wochen, beginnend mit dem Belastungsdatum, die '\
        + 'Erstattung des belasteten Betrages verlangen. Es gelten dabei die mit meinem '\
        + 'Kreditinstitut vereinbarten Bedingungen.'
        pdf.move_down 2.mm
        attendee_data = pdf.make_table([
                                         [{ content: 'IBAN:', width: 150 }, @person.sepa_iban],
                                         ['Mandatsreferenz:', 'wsjrdp' + @person.id.to_s],
                                         ['Gläubiger*innen-Identifikationsnummer:',
                                          'DE81 WSJ 0000 2017 275'], # Todo
                                         ['Kontoinhaber*in:', @person.sepa_name],
                                         ['Adresse:', @person.sepa_address]
                                       ],
                                       cell_style: { padding: 1, border_width: 0,
                                                     inline_format: true })
        attendee_data.draw

        pdf.move_down 5.mm



        text 'Lastschrifteinzug', size: 10

        pdf.move_down 3.mm
        text 'Das SEPA-Mandat wird nach folgendem Plan,'\
        +" für #{role_full_name(@person.role_wish)}, eingezogen."\
        + ' Der Einzug erfolgt am 5. des jeweigen Monats bzw. am darauf folgenden Werktag.'
        pdf.move_down 3.mm
        pdf.make_table(payment_array_by(@person.role_wish), cell_style: { padding: 1,
                                                                          border_width: 0,
                                                                          inline_format: true,
                                                                          size: 6 }).draw
        pdf.move_down 3.mm
        pdf.make_table([
                         [{ content: @person.town + ' den ' + Time.zone.today.strftime('%d.%m.%Y'),
                            height: 30 }],
                         ['______________________________', ''],
                         [{ content: @person.sepa_name, height: 30 }, '']
                       ],
                       cell_style: { width: 240, padding: 1, border_width: 0,
                                     inline_format: true }).draw
        # TODO: AV
        # pdf.move_down 3.mm
        # pdf.stroke_horizontal_rule


        # pdf.move_down 3.mm
        # text 'AV Ü18', size: 12
        # text 'TODO AV Formulierung kommt noch'
        # signature.draw

        text ''
      end

      def qrcode_content
        'http://' + ENV['RAILS_HOST_NAME'] + '/groups/' + @person.primary_group_id.to_s +
          '/people/' + @person.id.to_s + '/check/' + document_id
      end
    end
    # rubocop:enable Metrics/AbcSize,Metrics/MethodLength,Metrics/CyclomaticComplexity


  end
end
