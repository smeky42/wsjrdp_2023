# frozen_string_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_wsjrdp_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_wsjrdp_2023.

module Wsjrdp2023
  module Export::Pdf::Registration
    class Contract < Section

      def render
        pdf.y = bounds.height - 60
        bounding_box([0, 230.mm], width: bounds.width, height: bounds.height - 200) do
          font_size(8) do
            text list, style: :italic, width: bounds.width
          end
        end
      end

      # rubocop:disable AbcSize,MethodLength
      def list
        of_legal_age = false # @person.years.to_i >= 18

        if of_legal_age
          signature = pdf.make_table([
                                       [{ content: @person.town + ' den ' \
                                        + Time.zone.today.strftime('%d.%m.%Y'), height: 30 }],
                                       ['______________________________', ''],
                                       [{ content: @person.full_name, height: 30 }, '']
                                     ],
                                     cell_style: { width: 240, padding: 1, border_width: 0,
                                                   inline_format: true })
        else
          signature = pdf.make_table([
                                       [{ content: @person.town + ' den ' \
                                         + Time.zone.today.strftime('%d.%m.%Y'), height: 30 }],
                                       %w(__________________________ __________________________),
                                       [{ content: 'Sorgeberechtigte*r', height: 30 },\
                                        + 'Sorgeberechtigte*r'],
                                       ['______________________________', ''],
                                       [{ content: @person.full_name, height: 30 }, '']
                                     ],
                                     cell_style: { width: 240, padding: 1, border_width: 0,
                                                   inline_format: true })
        end


        text 'HowTo', size: 12
        text 'ToDo Erklärung welchen Weg das Dokument nimmt -> Hochladen erstes Unit Treffen'
        text 'ToDo QR Code für die Nachverfolgung'
        text 'ToDo Alleinerziehend nur eine Unterschrift + Nachweis'
        pdf.stroke_horizontal_rule
        pdf.move_down 3.mm

        text 'Anmeldung', size: 12

        text 'von ' + @person.full_name + ', geboren am ' + @person.birthday.strftime('%d.%m.%Y') \
        + ', wohnhaft in ' + @person.address + ', ' + @person.zip_code + ', ' + @person.town
        text 'beim Ring deutscher Pfadfinder*innenverbände e.V (rdp) Chausseestraße 128/129,'\
        + ' 10115 Berlin.'
        text ' für das deutsche Kontingent zum 25. World Scout Jamboree 2023 in Südkorea.'

        pdf.move_down 3.mm
        text 'Die Teilnahme im Deutschen Kontingent kostet TODO Preis € und beinhaltet'\
        + ' die Vor- und Nachbereitung in Deutschland,'\
        + ' die Teilnahme am 25. World Scout Jamboree in Südkorea,'\
        + ' die Reise nach Südkorea (nur Units)'\
        + 'eine Vor oder Nachtour (nur Units).'
        text 'Die Reise ist für den Zeitraum vom 20.07 bis 21.08.2023'\
        +' geplant. Der Reisezeitraum variiert je nach gewähltem Paket und Lage der'\
        +' Sommerferien, Reisedauer sind 13 bis 25 Tage.'

        pdf.move_down 3.mm

        text 'Hiermit ' + (of_legal_age ? 'melde ich mich ' : 'melden wir unser Kind ') \
        + @person.full_name + ', geboren am ' + @person.birthday.strftime('%d.%m.%Y') \
        + ' verbindlich mit dem Paket ' + 'TODO paket' + ' zur Teilnahme im Deutschen Kontingent'\
        + ' zum 25. World Scout Jamboree 2023 an. Mit '\
        + (of_legal_age ? 'meiner Unterschrift bestätige ich' :
          'unserer Unterschrift bestätigen wir')\
        + ' die Kenntnis- und Annahme'\
        + ' der Reisebedingungen des Veranstalters (rdp) in Version 1.0 vom 31.07'\
        + ' (TODO Downloadlink).'

        pdf.move_down 3.mm

        text 'Anlagen zum Dokument sind die Datenschutzhinweise in Version 1.0 vom 31.07 '\
        + ' (TODO Downloadlink) und die Medienrichtlinie (rdp) in Version 1.0 vom 31.07'\
        + ' (TODO Downloadlink) im Anhang.'
        text '' + (of_legal_age ? 'Ich bestätige' : 'Wir bestätigen') + ' die Dokumente'\
        + ' zur Kenntnis genommen zu haben. Das gilt Insbesondere für die Hinweise zur'\
        + ' Datenübtragung zum Veranstalter im nicht EU-Ausland, zu Bild und Tonaufnahmen'\
        + ' und zur Erfassung und Weitergabe von Gesundheitsdaten.'
        pdf.move_down 3.mm

        text 'Den Medizinbogen im Anhang haben wir gesondert unterschrieben.'
        pdf.move_down 3.mm

        unless of_legal_age
          text 'Für die Dauer der Reise übertragen wir die Ausübung der Aufsichtspflicht und das'\
        + ' Aufenthaltsbestimmungsrecht über unser Kind dem Reiseveranstalter. Wir sind damit'\
        + ' einverstanden, dass die Ausübung im erforderlichen Ausmaß auf volljährige'\
        + ' Betreuer*innen übertragen wird.'
          pdf.move_down 3.mm
        end
        signature.draw
        pdf.stroke_horizontal_rule
        pdf.move_down 4.mm

        text 'SEPA Lastschriftverfahren', size: 12
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
                                         [{ content: 'IBAN:', width: 150 }, 'TODO @person.iban'],
                                         ['Mandatsreferenz:', 'wsjrdp' + @person.id.to_s],
                                         ['Gläubiger*innen-Identifikationsnummer:', 'TODO IBAN'],
                                         ['Kontoinhaber*in:', 'TODO @person.sepa_name']
                                       ],
                                       cell_style: { padding: 1, border_width: 0,
                                                     inline_format: true })
        attendee_data.draw

        pdf.move_down 5.mm

        pdf.make_table([
                         [{ content: @person.town + ' den ' + Date.today.strftime('%d.%m.%Y'),
                            height: 30 }],
                         ['______________________________', ''],
                         [{ content: 'TODO @person.sepa_name', height: 30 }, '']
                       ],
                       cell_style: { width: 240, padding: 1, border_width: 0,
                                     inline_format: true }).draw
        pdf.move_down 3.mm
        pdf.stroke_horizontal_rule


        pdf.move_down 3.mm
        text 'AV Ü18', size: 12
        text 'TODO AV Formulierung kommt noch'
        signature.draw

        text ''
      end
      # rubocop:enable AbcSize,MethodLength
    end
  end
end
