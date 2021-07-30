# frozen_string_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_wsjrdp_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_wsjrdp_2023.

module Wsjrdp2023
  module Export::Pdf::Registration
    class Recommondation < Section
      def render
        pdf.y = bounds.height - 60
        bounding_box([0, 230.mm], width: bounds.width, height: bounds.height - 200) do
          font_size(8) do
            text list, style: :italic, width: bounds.width
          end
        end
      end

      # TODO: Komplett überarbeiten
      # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
      def list
        pdf.start_new_page
        pdf.move_down 3.mm
        text 'Was muss ich mit der Empfehlung machen machen?', size: 12
        text 'Die Empfehlung muss'
        text '1. vollständig unterschrieben werden'
        text '2. auf anmeldung.worldscoutjamboree.de unter "Upload>Empfehlung hochladen"'\
        + ' hochgeladen werden'
        pdf.move_down 3.mm
        pdf.stroke_horizontal_rule

        pdf.move_down 3.mm

        text 'Empfehlung als Mitglied einer Unitleitung für das World Scout Jamboree 2023', size: 14
        pdf.move_down 3.mm
        text 'Im Sommer 2023 findet das 25. World Scout Jamboree in Korea statt. Wir als'\
        + ' Ring deutscher Pfadfinder*innen wollen aus unserem'\
        + ' Selbstverständnis heraus dort gemeinsam als deutsche Pfadfinder*innen auftreten.'
        pdf.move_down 1.mm
        text 'Unser Ziel ist es, dass für alle Units des verbandsübergreifenden deutschen'\
        + ' Kontingents die gleichen Maßstäbe, Kosten und Vorbereitungsstandards gelten und'\
        + ' die Jugendlichen durch ein Team aus vier Unitleitungen auf ihrem Erlebnis Jamboree'\
        + ' bestmöglich vorbereitet, unterstützt und geleitet werden.'
        pdf.move_down 1.mm
        text 'Da für die Mitglieder der Unitleitung die langfristige Übernahme von Verantwortung'\
        + ' sowie Zuverlässigkeit, Teamfähigkeit und weitere Kompetenzen erforderlich sind, gehört'\
        + ' zu unserem Anmelde- und Auswahlverfahren für'\
        + ' Unitleitungen eine Empfehlung für die jeweilige'\
        + ' Person. Dies erfolgt durch die Leitung/Vorstand'\
        + ' des jeweiligen Landes- (VCP, BdP, BMPPD)'\
        + ' bzw. Diözesanverbandes (DPSG).'
        text ' Solltest du'\
        + ' den*die Bewerber*in nicht persönlich kennen,'\
        + ' erkundige dich bitte bei anderen Ebenen, ob dem*der Bewerber*in die Leitung einer Unit'\
        + ' zugetraut werden kann. Schon einmal ein herzliches'\
        + ' Dankeschön dafür, dass du uns bei der'\
        + ' Suche geeigneter Unitleitungen unterstützt!'
        pdf.move_down 3.mm
        text 'Hiermit bestätige ich, '
        pdf.move_down 5.mm
        text 'Name: _____________________________ '
        pdf.move_down 5.mm
        text 'Amt: _____________________________ im'\
        + ' Landes-/Diözesanverband _______________________,'
        pdf.move_down 1.mm
        text 'dass ich ' + @person.full_name + ' für geeignet halte, Mitglied einer Unitleitung'\
        + ' für das World Scout Jamboree 2023 zu sein. Sie*er bringt die notwendigen Kompetenzen'\
        + ' für diese Aufgabe mit und kann dadurch für seine Unit zu einem unvergesslichem'\
        + ' Jamboreeerlebnis maßgeblich beitragen.'

        pdf.make_table([
                         [{ content: '', height: 30 }],
                         ['______________________________', ''],
                         [{ content: 'Ort, Datum, Unterschrift', height: 30 }, '']
                       ],
                       cell_style: { width: 240, padding: 1, border_width: 0,
                                     inline_format: true }).draw
        text ''
      end
      # rubocop:enable Metrics/AbcSize,Metrics/MethodLength
    end
  end
end
