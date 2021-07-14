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
                                       [{ content: 'Personensorgeberechtigte*r', height: 30 },\
                                        + 'Personensorgeberechtigte*r'],
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
        text 'Die Teilnahme im deutschen Kontingent kostet TODO Preis € und beinhaltet'\
        + ' die Vor- und Nachbereitung in Deutschland,'\
        + ' die Teilnahme am 25. World Scout Jamboree in Südkorea,'\
        + ' die Reise nach Südkorea (nur Units)'\
        + ' eine Vor- oder Nachtour (nur Units).'
        text 'Die Reise ist für den Zeitraum vom 20.07 bis 21.08.2023'\
        +' geplant. Der Reisezeitraum variiert je nach gewähltem Paket und Lage der'\
        +' Sommerferien, Reisedauer sind 13 bis 25 Tage.'

        pdf.move_down 3.mm
        text 'Hiermit ' + (of_legal_age ? 'melde ich mich ' : 'melden wir unser Kind ') \
        + @person.full_name + ', geboren am ' + @person.birthday.strftime('%d.%m.%Y') \
        + ' verbindlich mit dem Paket ' + 'TODO paket' + ' zur Teilnahme im Deutschen Kontingent'\
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
        +' abfragt. Der rdp muss diese ergänzenden Bedingungen an alle Teilnehmer'\
        +' weitergeben, obwohl er auf den Inhalt keinen Einfluss hat, weil sonst'\
        +' eine Teilnahme nicht möglich ist. Die Teilnehmer werden über diese Änderungen'\
        +' in Textform unterrichtet. Sollte der Teilnehmer mit diesen ergänzenden Bedingungen'\
        +' nicht einverstanden sein, kann er nach Maßgabe von TODO $$$ der Reisebedingungen zu'\
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
        text '- die Reisebedingungen des rdp (v1.0 vom 31.07)'
        text '- die Datenschutzhinweise (v1.0 vom 31.07), insbesondere die Informationen zu TODO$'
        text '- die Medienrichtlinie (v1.0 vom 31.07)'
        text 'Die Dokumente sind auch unter TODO Downloadlink verfügbar.'
        pdf.move_down 3.mm

        text 'Den Medizinbogen im Anhang haben wir gesondert unterschrieben.'
        pdf.move_down 3.mm

        pdf.move_down 3.mm
        signature.draw


        pdf.start_new_page
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
