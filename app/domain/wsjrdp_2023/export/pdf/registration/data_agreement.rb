# frozen_string_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_wsjrdp_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_wsjrdp_2023.

module Wsjrdp2023
  module Export::Pdf::Registration
    # rubocop:disable ClassLength
    class DataAgreement < Section
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
        pdf.start_new_page
        text 'Datenschutzrechtlichen Daten Datenspeicherung und -nutzung zum Zwecke der '\
        + 'Durchführung der Veranstaltung', size: 14
        text 'Ich bin damit einverstanden, dass die, im Folgenden aufgeführten Daten im Rahmen'\
        + ' meiner Teilnahme am World Scout Jamboree und den damit verbundenen Angeboten bzw.'\
        + ' Veranstaltungen des Deutschen Kontingents (Vorbereitung auf das World Scout Jamboree,'\
        + ' Kontingentslager in Deutschland, Akklimatisierungstage in Süd-Korea, World Scout'\
        + ' Jamborees, ggf. Vor- und Nachtouren, ggf. Reflexionstreffen, ggf. Home Hospitality)'\
        + ' gespeichert und genutzt werden dürfen.'

        pdf.move_down 3.mm
        text 'Speicherung der Daten', size: 12

        text 'A) Kontaktdaten, Status, Flug, Rolle im Kontingent, Paket / Zahlungsdetails, '\
        + 'Gesetzliche Vertreter, Notfallkontakt, Reisedokumente, Zusätzliche Informationen,'\
        + ' Kontingentslager, Administratives'
        pdf.indent(10) do
          pdf.indent(10) do
            pdf.move_down 1.mm
            text '1. Zu den Daten der Teilnehmer*innen haben folgende Personengruppen Zugang:'
            pdf.indent(10) do
              pdf.move_down 1.mm
              text 'a) Die jeweils zuständigen Unitleiter*innen zur internen Kommunikation, '\
                + 'Vor- und Nachbereitung der Fahrt und Organisation der Unit.'
              pdf.move_down 1.mm
              text 'b) Die jeweils zuständigen Mitglieder des Kontingentsteams und der '\
                + 'Kontingentleitung zur Planung und Organisation der Veranstaltungen rund um das '\
                + 'World Scout Jamboree (s.o), für die Anmeldung bei den Veranstaltern, für die '\
                + 'Zuordnung zu den Units, für administrative Zwecke, für die Buchung von '\
                + 'Unterkünften, '\
                + 'Flügen und sonstigen Transportmitteln sowie für die medizinische Betreuung. '\
                + 'Im Einzelnen sind das die Mitglieder der Kontingentleitung, die '\
                + 'Unitbetreuer*innen, '\
                + 'die Systemadministratoren, die Ärztinnen, die Tourenplaner*innen, die '\
                + 'Logistiker*innen.'
              pdf.move_down 1.mm
              text 'c) Die Verwaltungsangestellten in der Bundesstelle des BdP zur administrativen'\
                + ' Durchführung der Veranstaltungen.'
            end
          end
          pdf.indent(10) do
            pdf.move_down 1.mm
            text '2. Zu den Daten der Unitleiter*innen, des ISTs, des Kontingentsteams haben '\
              + 'folgende Personengruppen Zugang:'
            pdf.indent(10) do
              pdf.move_down 1.mm
              text 'a) Die jeweils zuständigen Mitglieder des Kontingentsteams und der '\
                + 'Kontingentleitung zur Planung und Organisation der Veranstaltungen rund um das '\
                + 'World Scout Jamboree (s.o), für die Anmeldung bei den Veranstaltern, für die '\
                + 'Organisation der Zusammenarbeit im Kontingentsteam, für administrative Zwecke, '\
                + 'für die Buchung von Unterkünften, Flügen und sonstigen Transportmitteln sowie '\
                + 'für die medizinische Betreuung. Im Einzelnen sind das die Mitglieder der '\
                + 'Kontingentsleitung, die Systemadministratoren, die Mediziner*innen, die '\
                + 'Tourenplaner*innen, die Logistiker*innen.'
              pdf.move_down 1.mm
              text 'b) Die Verwaltungsangestellten in der Bundesstelle des BdP zur administrativen'\
                + ' Durchführung der Veranstaltungen.'
            end
          end
        end
        pdf.move_down 1.mm
        text 'B) Medizinische Daten'
        pdf.indent(10) do
          pdf.move_down 1.mm
          text '1. Zu den Daten der Teilnehmer*innen haben folgende Personengruppen Zugang:'
          pdf.indent(10) do
            pdf.move_down 1.mm
            text 'a) Die jeweils verantwortlichen Unitleiter*innen und Unitbetreuer*innen. '\
              + 'Als verantwortliche Aufsichtspersonen sollten die Unitleiter*innen mit den '\
              + 'medizinischen Bedürfnissen bzw. Vorgeschichten der Teilnehmer*innen '\
              + 'vertraut sein. So können sie ggf. notwendige Vorbereitungen treffen '\
              + '(z.B. Absprachen im Vorfeld mit Eltern und/oder Teilnehmenden) und im '\
              + 'Rahmen des Projekts die bestmögliche medizinische Betreuung sicherstellen '\
              + 'bzw. organisieren. Im Falle einer Krankheit oder eines Unfalls können sie '\
              + '(ggf. nach Absprache mit den Eltern, der Kontingentsärzt*innen sowie des '\
              + 'medizinischen Personals auf dem Jamboree) angemessen reagieren und auf '\
              + 'Basis der Informationen bestmöglich Entscheidungen zum weiteren Vorgehen treffen.'
            pdf.move_down 1.mm
            text 'b) Die Mediziner*innen. Aufgabe der Mediziner*innen ist die Beratung '\
              + 'und/oder Behandlung von Teilnehmer*innen im Rahmen der Vorbereitung zum '\
              + 'Jamboree, der Teilnahme am World Scout Jamboree und den damit zusammenhängenden '\
              + 'Angeboten des deutschen Kontingents. Damit sich die Ärzt*innen im Vorfeld auf '\
              + 'ihre Aufgabe vorbereiten können, ist es notwendig, dass sie Zugang zu den '\
              + 'hier abgefragten Informationen bekommen. Das erleichtert es ihnen, '\
              + 'entsprechende Vorkehrungen zu treffen, vor Ort medizinische '\
              + 'Situationen schnell und angemessen einzuschätzen und (in Absprache '\
              + 'mit den Teilnehmer*innen, den Unitleiter*innen, den Eltern und '\
              + 'dem medizinischen Personal auf dem Jamboreegelände) entsprechende '\
              + 'Behandlungen durchführen oder in die Wege leiten zu können.  Die '\
              + 'Kontingentsärzt*innen unterliegen der Schweigepflicht. Falls es '\
              + 'notwendig ist, werden sie sich aber ggf. – nach Rücksprache mit '\
              + 'den Teilnehmer*innen / Eltern / Unitleiter*innen –  mit dem medizinischen '\
              + 'Personal auf dem Jamboree oder in koreanischen Krankenhäuser austauschen.'
            pdf.move_down 1.mm
            text 'c) Die Systemadministrator*innen des Deutschen Kontingents. '\
              + 'Aufgabe der Systemadministrator*innen ist die möglichst reibungslose '\
              + 'und sichere Verwaltung der Daten. Ziel muss es sein, dass die jeweils '\
              + 'zuständigen Personengruppen einen zuverlässigen Zugriff auf die '\
              + 'jeweils erforderlichen Daten haben. Daher kann es notwendig '\
              + 'werden, dass die Systemadministratoren ggf. auf die Daten zugreifen können. '
          end
          pdf.move_down 1.mm
          text '2. Zu den Daten der Unitleiter*innen, des ISTs, des Kontingentsteams haben '\
              + 'folgende Personengruppen Zugang:'
          pdf.indent(10) do
            pdf.move_down 1.mm
            text 'a) Die Kontingentsärzt*innen. Aufgabe der Mediziner*innen ist die '\
              + 'Beratung und/oder Behandlung von Teilnehmer*innen im Rahmen der '\
              + 'Vorbereitung zum Jamboree, der Teilnahme am World Scout Jamboree '\
              + 'und den damit zusammenhängenden Angeboten des deutschen Kontingents. '\
              + 'Damit sich die Mediziner*innen im Vorfeld auf ihre Aufgabe vorbereiten '\
              + 'können, ist es notwendig, dass sie Zugang zu den hier abgefragten '\
              + 'Informationen bekommen. Das erleichtert es ihnen, entsprechende '\
              + 'Vorkehrungen zu treffen, vor Ort medizinische Situationen schnell '\
              + 'und angemessen einzuschätzen und in Absprache mit den Teilnehmenden '\
              + 'und dem medizinischen Personal auf dem Jamboreegelände entsprechende '\
              + 'Behandlungen durchführen oder in die Wege leiten zu können.'
            pdf.move_down 1.mm
            text 'Die Kontingentsärzt*innen unterliegen der Schweigepflicht. '\
              + 'Falls es notwendig ist, werden sie sich aber ggf. – nach '\
              + 'Rücksprache mit den Teilnehmenden –  mit dem medizinischen '\
              + 'Personal auf dem Jamboree oder in koreanischen Krankenhäuser austauschen.'
            pdf.move_down 1.mm
            text 'b) Die Systemadministrator*innen des Deutschen Kontingents. '\
              + 'Aufgabe der Systemadministrator*innen ist die möglichst '\
              + 'reibungslose und sichere Verwaltung der Daten. Ziel muss '\
              + 'es sein, dass die jeweils zuständigen Personengruppen einen '\
              + 'zuverlässigen Zugriff auf die jeweils erforderlichen Daten '\
              + 'haben. Daher kann es notwendig werden, dass die '\
              + 'Systemadministrator*innen ggf. auf die Daten zugreifen können.'
          end
        end
        pdf.move_down 3.mm
        text 'Weiterleitung der Daten an Dritte', size: 12

        pdf.move_down 3.mm
        text 'Jamboree-Veranstalter', size: 10
        pdf.move_down 1.mm
        text 'Die abgefragten Daten werden zu Zwecken der Durchführung des World Scout '\
              + 'Jamboree 2023 auch in die Republik Korea (Südkorea), dort an die '\
              + '(TODO Jamboree) Veranstalter Adresse weitergegeben. Für die Weitergabe '\
              + 'der Daten wurde ein entsprechendes Data Protection Agreement mit den '\
              + 'Veranstaltern getroffen.'
        pdf.move_down 1.mm
        text 'Mir ist bekannt und bewusst, dass die in der Republik Korea geltenden '\
              + 'Datenschutzbestimmungen ein geringeres Datenschutzniveau bieten als '\
              + 'die in der EU.'
        pdf.move_down 1.mm
        text 'Mir ist bekannt und bewusst, dass eine Teilnahme am World Scout '\
              + 'Jamboree 2023 ohne die Übermittlung der Daten an die Veranstalter '\
              + 'nicht möglich sein wird.'
        pdf.move_down 1.mm
        text 'Mir ist bekannt und bewusst, dass die Veranstalter vor Ort weitere '\
              + 'medizinische Daten abfragen werden. Nach unserer Kenntnis wird die '\
              + 'Beantwortung dieser Fragen Voraussetzung für das Betreten des '\
              + 'Jamboree-Geländes sein.'
        pdf.move_down 1.mm
        text 'Mir ist bekannt und bewusst, dass die Veranstalter die '\
              + 'Teilnehmer*innen ggf. auffordern, den Gesundheitsbogen auf '\
              + 'Papier stets mit sich zu tragen. Unitleiter*innen sollen die '\
              + 'Gesundheitsbögen ihrer Unit-Mitglieder ebenfalls mit auf das '\
              + 'Jamboree-Gelände bringen.'

        pdf.move_down 3.mm
        text 'Reiseveranstalter', size: 10
        pdf.move_down 1.mm
        pdf.move_down 1.mm
        text 'Ich bin damit einverstanden, dass die folgenden Daten an den '\
              + '(TODO Reiseveranstalter Consense Adresse) weitergegeben werden: '\
              + 'Nachname, Vorname, Adresse, Mailadresse, Geburtstag, Geschlecht, '\
              + 'Flugdetails, Datum Hinflug, Datum Rückflug, Essen im Flugzeug, '\
              + 'Flugsonderwunsch, Reisepassnummer. TODO Daten mit Veranstalter abklären'
        pdf.move_down 1.mm
        text 'Die Weitergabe der Daten dient dazu, Flüge, Unterkünfte und ggf. '\
              + 'weitere Transportmittel zum Jamboree und/oder den Angeboten des '\
              + 'Deutschen Kontingents im Zusammenhang mit dem Jamboree zu buchen.'

        pdf.move_down 3.mm
        text 'Widerspruchsrecht', size: 10

        pdf.move_down 1.mm
        text 'Mir ist bewusst, dass ich diese Einwilligung jederzeit ohne Angabe '\
              + 'von Gründen für die Zukunft widerrufen kann, indem ich dem '\
              + 'Deutschen Kontingent für das World Scout Jamboree postalisch '\
              + 'oder per Mail meinen Widerruf gegen die Speicherung und '\
              + 'Verarbeitung meiner personenbezogenen Daten mitteile.'
        pdf.move_down 1.mm
        text 'Die Widerrufserklärung ist zu richten an: Ring deutscher '\
              + 'Pfadfinder*innenverbände e.V. c/o BdP Bundesamt, '\
              + 'Kesselhaken 23, 34376 Immenhausen oder elektronisch an '\
              + 'datenschutz@worldscoutjamboree.de TODO Adresse, Muster Widerruf?'
        pdf.move_down 1.mm
        text 'Im Falle eines Widerrufs wird der rdp nach Zugang der '\
              + 'Widerrufserklärung meine Daten unverzüglich löschen. '\
              + 'Dass ich eine Löschung von Daten, die bereits an die '\
              + 'TODO Veranstalter einfügen weitergegeben wurden, nicht '\
              + 'erreichen kann, ist mir bewusst. Der rdp wird nach '\
              + 'Eingang einer Widerrufserklärung die TODO Veranstalter '\
              + 'einfügen bitten, die mich betreffenden Daten zu löschen.'
        pdf.move_down 1.mm
        text 'Der Widerruf hat die Rückabwicklung des Reisevertrags zur '\
              + 'Folge. Der Veranstalter kann in Folge des Widerrufs vom '\
              + 'Vertrag zurücktreten. Ich verpflichte mich, den hieraus '\
              + 'entstehenden Schaden zu begleichen. Der Schadensersatzanspruch '\
              + 'des rdp ermittelt sich gemäß den Reisebedingungen.'

        text ''
      end
      # rubocop:enable AbcSize,MethodLength
    end
    # rubocop:enable ClassLength
  end
end
