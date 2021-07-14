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

      # rubocop:disable AbcSize,MethodLength,PerceivedComplexity,CyclomaticComplexity
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
                                       [{ content: 'Erziehungsberechtigte*r', height: 30 },\
                                        + 'Erziehungsberechtigte*r'],
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

        text 'Teilnahmevertrag', size: 12

        text 'zwischen ' + @person.full_name  \
        + ', wohnhaft in ' + @person.address + ', ' + @person.zip_code + ', ' + @person.town
        text 'und dem Ring deutscher Pfadfinder*innenverbände e.V (rdp) Chausseestraße 128/129,'\
        + ' 10115 Berlin.'

        pdf.move_down 3.mm

        text 'Hiermit ' + (of_legal_age ? 'melde ich mich ' : 'melden wir unser Kind ') \
        + @person.full_name + ', geboren am ' + @person.birthday.strftime('%d.%m.%Y') \
        + ' verbindlich als ' + 'TODO @person.role' + ' zur Teilnahme im Deutschen Kontingent'\
        + ' zum 25. World Scout Jamboree 2023 an. Mit '\
        + (of_legal_age ? 'meiner Unterschrift'\
        + ' bestätige ich' : 'unserer Unterschrift bestätigen wir') + ' die Kenntnis- und Annahme'\
        + ' der Reisebedingungen des Veranstalters (rdp) im Anhang (TODO Eindeutige Referenz).'
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
        + 'Kreditinstitut vereinbarten Bedingungen. TODO ist dieser Satz notwendig?'
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
        pdf.stroke_horizontal_rule
        pdf.move_down 3.mm
        text 'DSGVO', size: 12
        text 'Im Weiteren ist ' + (of_legal_age ? 'mir' : 'uns') + ' bekannt, dass eine Teilnahme '\
        + (of_legal_age ? 'meine' : 'unseres Kindes ') + ' an die Zustimmung zum Vertrag zur '\
        + 'Datenspeicherung und -nutzung zum Zwecke der Durchführung (siehe Anhang) gebunden ist.'

        pdf.move_down 1.mm

        text 'Der rdp weist hiermit darauf hin, dass ausreichende technische Maßnahmen zur '\
        + 'Gewährleistung des Datenschutzes getroffen wurden. Dennoch kann bei einer '\
        + 'Veröffentlichung von personenbezogenen Mitgliederdaten im Internet ein umfassender '\
        + 'Datenschutz nicht garantiert werden. Daher nimmt der Teilnehmende die Risiken für '\
        + 'eine eventuelle Persönlichkeitsrechtsverletzung zur Kenntnis und ist sich bewusst, dass:'
        pdf.move_down 1.mm
        text '- die personenbezogenen Daten auch in Staaten abrufbar sind, die keine der '\
        + 'Bundesrepublik Deutschland vergleichbaren Datenschutzbestimmungen kennen,'
        pdf.move_down 1.mm
        text '- die Vertraulichkeit, die Integrität (Unverletzlichkeit), die Authentizität '\
        + '(Echtheit) und die Verfügbarkeit der personenbezogenen Daten nicht garantiert ist.'

        pdf.move_down 3.mm
        text '' + (of_legal_age ? 'Ich bestätige' : 'Wir bestätigen') + 'das Dokument im Anhang '\
        + 'zur Kenntnis genommen zu haben und ' + (of_legal_age ? 'willige' : 'willigen') \
        + ' ein, '\
        + 'dass der rdp die, im Anhang genannten Daten zu TODO NAME wie im Anhang angegeben '\
        + 'speichert und TODO Drittanbieter zur Durchführung des World Scout Jamborees 2023 '\
        + 'weiter gibt.'
        pdf.move_down 3.mm

        signature.draw

        pdf.stroke_horizontal_rule
        pdf.move_down 3.mm
        text 'Medizinbogen', size: 12
        text '' + (of_legal_age ? 'Ich habe' : 'Wir haben') + ' den Gesundheitsfragebogen '\
        + 'warheitsgemäß ausgefüllt.'
        pdf.move_down 1.mm
        text '' + (of_legal_age ? 'Ich bin' : 'Wir sind') + ' damit einverstanden, dass die '\
        + 'persönlichen Daten und so wie Behandlungsdaten zum Zwecke der gesetzlich '\
        + 'vorgeschriebenen Dokumentation gespeichert werden. Nach Ablauf der gesetzlichen '\
        + 'Aufbewahrungsfrist werden die Daten gelöscht.'
        pdf.move_down 3.mm
        signature.draw

        pdf.stroke_horizontal_rule
        pdf.move_down 3.mm
        text 'Verwendung von Medien', size: 12
        text 'Im Weiteren ist ' + (of_legal_age ? 'mir' : 'uns') + ' bekannt, dass eine'\
        + ' Teilnahme ' + (of_legal_age ? 'meine' : 'unseres Kindes') + ' an die '\
        + 'Vereinbarung über die Nutzung von Fotografien und Filmen für die'\
        + ' Berichterstattung des Rings deutscher Pfadfinder*innen e.V. (rdp) '\
        + 'und seiner Mitgliedsverbände für das World Scout Jamboree 2023 gebunden ist.'
        pdf.move_down 3.mm
        text '' + (of_legal_age ? 'Ich bestätige' : 'Wir bestätigen') + ' das Dokument im '\
        + 'Anhang zur Kenntnis genommen zu haben und willigen in die Nutzung von '\
        + 'Fotografien und Filmen für die Berichterstattung des Ringes deutscher '\
        + 'Pfadfinder*innen e.V. (rdp) und seiner Mitgliedsverbände für das World '\
        + 'Scout Jamboree 2023 ein:'
        pdf.move_down 3.mm
        signature.draw

        pdf.stroke_horizontal_rule
        pdf.move_down 3.mm
        text 'AV Ü18', size: 12
        text 'TODO AV Formulierung'
        signature.draw

        text ''
      end
      # rubocop:enable AbcSize,MethodLength,PerceivedComplexity,CyclomaticComplexity

    end
  end
end
