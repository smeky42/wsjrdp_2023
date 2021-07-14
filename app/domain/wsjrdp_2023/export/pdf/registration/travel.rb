# frozen_string_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_wsjrdp_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_wsjrdp_2023.

module Wsjrdp2023
  module Export::Pdf::Registration
    # rubocop:disable ClassLength
    class Travel < Section
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
        text 'Teilnahme- und Reisebedingungen zur Teilnahme im Deutschen Kontingent zum 25. World '\
        +'Scout Jamboree 2023 in Südkorea', size: 14

        pdf.move_down 3.mm
        text 'Ein paar Fakten im Überblick', size: 14
        pdf.move_down 3.mm
        text 'Veranstalter', size: 12
        pdf.move_down 1.mm
        text 'Ringe deutscher Pfadfinder*innenverbände e.V.(rdp),'
        text 'Vertreten durch Joschka Hench, Sebastian Köngeter, Oliver Mahn, Naima Hartit'
        text 'Chausseestraße 128/129'
        text '10115 Berlin'
        text 'Telefonnummer Büro: +49 30 288 7895 35'

        pdf.move_down 3.mm
        text 'Organisation / Kontakt', size: 12
        pdf.move_down 1.mm
        text 'Organisatorischer Ansprechpartner ist neben dem Veranstalter, die Kontingentsleitung'\
        +' zum World Scout Jamboree 2023. Die Kontingentsleitung ist wie folgt zu erreichen:'
        text 'Telefon: TODO Telefon?'
        text 'E-Mail: info@worldscoutjamboree.de'
        text 'Weitere Kontaktdaten gibt es auf der Homepage: www.worldscoutjamboree.de'
        text 'Verantwortlich ist ausschließlich der rdp.'

        pdf.move_down 3.mm
        text 'Reisezeitraum', size: 12
        pdf.move_down 1.mm
        text 'Die Fahrt des rdp-Kontingents ist für den Zeitraum vom 20.07 bis 21.08.2023'\
        +' geplant. Der Reisezeitraum variiert je nach gewähltem Paket und Lage der'\
        +' Sommerferien, Reisedauer sind 13 bis 25 Tage. Die genauen Reisedaten'\
        +' werden im Herbst 2022 feststehen, da erst zu diesem Zeitpunkt die tatsächlichen'\
        +' Flugdaten festgelegt werden können. Die Teilnehmenden werden über die,'\
        +' in der Anmeldung angegebenen Mailadressen über die Reisedaten informiert.'

        pdf.move_down 3.mm
        text 'Reiseziel', size: 12
        pdf.move_down 1.mm
        text 'Das Reiseland ist die Republik Korea (Südkorea). Nach Abschluss der Planung'\
        +' werden genaue Reisedetails bekannt gegeben.'

        pdf.move_down 3.mm
        text 'Reiseform / Pakete', size: 12
        pdf.move_down 1.mm
        text 'Die Teilnahme am World Scout Jamboree 2023 unterscheidet sich je nach Rolle im'\
        +' Deutschen Kontingent. Es gibt jeweils Reisepakete für:'

        pdf.move_down 3.mm
        pdf.indent(10) do
          text 'Teilnehmende in Units (Unitleiter*innen und Teilnehmer*innen)', size: 10
          pdf.move_down 1.mm
          pdf.indent(10) do
            text 'Die Reise von Teilnehmer*innen (TN) und Unitleiter*innen (UL) findet in ihren'\
            +' Units statt. Eine Unit besteht regelmäßig aus 36 Teilnehmer*innen im Alter zwischen'\
            +' 14-18 Jahren und 4 volljährigen Unitleiter*innen. Die Zuteilung in Units wird vom'\
            +' Kontingentsteam ab Herbst 2021 unter Berücksichtigung der Wünsche der Teilnehmenden'\
            +' vorgenommen.'
            text 'Vor der Reise nach Südkorea finden verbindliche Vorbereitungstreffen in der'\
            +' zugeteilten Unit statt, die mehrere Wochenenden umfassen. Die Termine werden von '\
            +'der jeweiligen Unitleitung mitgeteilt. Die Teilnahme an den Vorbereitungstreffen ist'\
            +' Voraussetzung für die Teilnahme am Jamboree.'
          end
          pdf.move_down 3.mm
          text 'Kontingentsteam (KT), Kontingentsleitung (KL + eKL) und International Service'\
          +' Team (IST)', size: 10
          pdf.move_down 1.mm
          pdf.indent(10) do
            text 'Für Kontingentsteam und ISTs finden Vor- und/oder Nachprogramm sowie die An- und'\
            +' Abreiseplanung in Eigenregie statt. Sie sind nicht im Reisepreis inbegriffen.'\
            +' Planung und Durchführung von Vor- und/oder Nachprogramm kann in Kleingruppen'\
            +' mit anderen Mitgliedern des Kontingents geschehen. Das Kontingent bietet auf'\
            +' den Vorbereitungstreffen die Möglichkeit Gruppen hierfür zu bilden. Vor der'\
            +' Reise nach Südkorea finden verbindliche Vorbereitungstreffen statt, die'\
            +' mehrere Wochenenden umfassen. Die Termine werden von der Kontingentsleitung'\
            +' mitgeteilt. Die Teilnahme an den Vorbereitungstreffen ist Voraussetzung für'\
            +' die Teilnahme am Jamboree.'
          end
        end

        pdf.move_down 3.mm
        text 'Teilnahmevoraussetzung & Vertragsschluss', size: 12
        pdf.move_down 1.mm
        text 'Teilnehmer*innen müssen zwischen dem 22.07.2005 - 31.07.2009 geboren sein.'\
        +' Erwachsene können nur als Unit- oder Kontingentsleitung, als'\
        +' Kontingentsteammitglied oder als Mitglieder des International Service'\
        +' Teams (IST) am Jamboree teilnehmen und die Durchführung unterstützen.'\
        +' Eine aktive Mitgliedschaft in einem der folgenden Pfadfinder*innenverbände'\
        +' ist Voraussetzung für die Teilnahme:'
        pdf.move_down 1.mm
        text '- Bund der Pfadfinderinnen und Pfadfinder (BdP),
        - Bund Moslemischer Pfadfinder und Pfadfinderinnen Deutschlands e.V. (BMPPD),
        - Deutsche Pfadfinderschaft Sankt Georg (DPSG),
        - Pfadfinderinnenschaft Sankt Georg (PSG),
        - Verband Christlicher Pfadfinderinnnen und Pfadfinder (VCP).'
        pdf.move_down 1.mm
        text 'Die Anmeldung ist bis zum 31.09.2021 über die Homepage'\
        +' anmeldung.worldscoutjamboree.de möglich. Während des Online-Anmeldeprozesses'\
        +' wird eine schriftliche Anmeldung generiert. Diese ist mit allen'\
        +' erforderlichen Unterschriften zu versehen und bis zum Anmeldeschluss am'\
        +' 31.09.2021 über die Homepage hoch zu laden. Die Anmeldung im Orginal'\
        +' (Papierform mit Unterschriften) muss spätestens zum 01.06.2022 bei den'\
        +' entsprechenden Betreuer*innen (UL, IST-Betreuung, eKL) abgegeben werden.'
        pdf.move_down 1.mm
        text 'Bei Personen, die zum Zeitpunkt der Anmeldung das 18. Lebensjahr noch nicht'\
        +' vollendet haben, muss die Anmeldung durch alle gesetzlichen Vertreter*innen'\
        +' unterzeichnet sein.'
        pdf.move_down 1.mm
        text 'Ein Vertrag über die Teilnahme kommt erst dann zustande, wenn der rdp die'\
        +' Anmeldung in Textform (z.B. E-Mail) bestätigt. Dies erfolgt erst nach Anmeldeschluss.'

        pdf.move_down 3.mm
        text 'Teilnahmebeitrag / Preiserhöhungen', size: 12
        pdf.move_down 1.mm
        text 'Der Teilnahmebetrag richtet sich nach der gewählten Teilnahmevariante (mit'\
        +' oder ohne Unit) und ggf. nach der Funktion im Kontingent. Für die Zahlungen'\
        +' ist die Erteilung eines SEPA-Basis-Lastschriftmandates erforderlich.'
        pdf.move_down 1.mm
        text 'Wenn sich nach Vertragsabschluss Beförderungskosten, Flughafengebühren, Steuern'\
        +' oder Wechselkurse verändern oder Änderungen am Programm vorgenommen werden müssen,'\
        +' behält sich der rdp vor, den Teilnahmebeitrag um den jeweiligen Erhöhungsbetrag'\
        +' anzupassen. Eine Preiserhöhung ab dem 20. Tag vor Reiseantritt ist unwirksam.'\
        +' Bei einer Preiserhöhung von mehr als 5%, ist der Teilnehmende berechtigt,'\
        +' kostenfrei vom Vertrag zurückzutreten. Bereits erhaltene Leistungen'\
        +' (z.B. Vortreffen) werden jedoch angerechnet. Der Rücktritt muss sodann gegenüber'\
        +' dem rdp, innerhalb von 14 Tagen nach der Erklärung über die Preiserhöhung'\
        +' bzw. der Änderung der Reiseleistung, schriftlich erklärt werden.'

        text 'TODO Höhe und Raten generieren'

        pdf.move_down 3.mm
        text 'Rücktritt vom Vertrag', size: 12
        pdf.move_down 1.mm
        text 'Der geschlossene Vertrag ist für beide Seiten bindend. Ein Rücktrittsrecht besteht'\
        +' nur in den gesetzlich vorgesehenen Fällen.'
        pdf.move_down 1.mm
        text 'Tritt die*der Teilnehmer*in vom Vertrag zurück, ohne hierzu berechtigt zu sein'\
        +' oder nimmt nicht an der Reise teil, steht dem rdp ein Schadenersatzanspruch zu.'\
        +' Ein Rücktritt ist schriftlich an den rdp (Adresse s.o.) zu richten. Andere sind'\
        +' nicht berechtigt, für den rdp den Rücktritt entgegenzunehmen. Dem rdp ist der'\
        +' entstandene Schaden pauschal gemäß folgender Staffel zu ersetzen:'
        pdf.move_down 1.mm
        text '
          bei Rücktritt bis zum 31.05.2022: 300,00 €,
          bei Rücktritt bis zum 30.09.2022: 25% des Teilnahmebeitrags,
          bei Rücktritt bis zum 31.12.2022: 50% des Teilnahmebeitrags,
          bei Rücktritt bis zum 31.03.2023: 75% des Teilnahmebeitrags,
          danach beträgt der Schaden 100% des Teilnahmebeitrags.'
        pdf.move_down 1.mm
        text 'Es steht der*dem Teilnehmer*in frei, einen geringeren oder keinen Schaden'\
        +' nachzuweisen. Der rdp kann weitergehende Schäden ebenfalls geltend machen.'
        pdf.move_down 1.mm
        text 'Eine nicht erteilte Schulbefreiung oder fehlende Einreisedokumente berechtigen'\
        +' nicht zum kostenfreien Reiserücktritt.'
        pdf.move_down 1.mm
        text 'Der rdp kann neben den gesetzlichen Gründen, wegen der Absage des "Jamborees"'\
        +' durch den Jamboree-Veranstalter (TODO Veranstalter) und nach erheblichem'\
        +' vertragswidrigen Verhalten der*des Teilnehmers*in vom Vertrag zurücktreten.'\
        +' Vor dem verhaltensbedingtem Rücktritt ist durch den rdp eine Mahnung in Textform'\
        +' (z.B. E-Mail) erforderlich. Daneben kann der rdp unter anderem bei folgenden'\
        +' Sachverhalten zurücktreten:'
        pdf.move_down 1.mm
        text '
          - wenn Lastschriften nicht eingelöst werden oder ihnen widersprochen wurde und'\
        +' nach Aufforderung der fällige Teil des Teilnahmebeitrags nicht innerhalb von'\
        +' zwei Wochen bezahlt wird
          - wenn die*der Teilnehmer*in nicht an den Vorbereitungstreffen teilnimmt
          - wenn die bei der Anmeldung abgefragten Daten zur Gesundheitsvorsorge nicht'\
        +' wahrheitsgemäß dem rdp zur Verfügung gestellt wurden
          - wenn die*der Teilnehmer*in gegen eine Satzung der Mitgliedsverbände (BdP, '\
        +'BMPPD, DPSG, PSG oder VCP) verstößt
          - wenn die*der Teilnehmer*in die Mitgliedschaft in seinem/ihrem Verband (BdP, '\
        +'BMPPD, DPSG, PSG oder VCP) aufgibt oder verliert
          - wenn andere wichtige Gründe (z.B. Reisebeschränkungen, Höhere Gewalt) es für '\
        +'den rdp unzumutbar erscheinen lassen, am Vertrag festzuhalten.'
        pdf.move_down 1.mm
        text 'Tritt der rdp aus einem, im vorherigen Abschnitt genannten Grund von dem'\
        +' Vertrag zurück, hat die*der Teilnehmer*in dem rdp den entstandenen Schaden'\
        +' gemäß obiger Staffel zu ersetzen. Eventuelle Mehrkosten für die Rückbeförderung'\
        +' muss die*der Teilnehmende selbst tragen. Es steht der*dem Teilnehmer*in'\
        +' frei, einen geringeren oder keinen Schaden nachzuweisen. Der rdp kann weitergehende'\
        +' Schäden ebenfalls geltend machen. TODO geht das so, weil zu undifferenziert'\
        +' Übervorteilung für den rdp'
        pdf.move_down 1.mm
        text 'NICHT im Teilnahmebeitrag enthalten sind: (TODO Versichrung Pflichten als'\
        +' Reiseanbieter wie haben wir das letztes mal gemacht?)'
        pdf.move_down 1.mm
        text '- Reiserücktrittversicherung
        - Gepäckversicherung
        - persönliche Ausgaben
        - Kosten für Einreisegenehmigungen nach Korea'
        pdf.move_down 1.mm
        text 'Es bleibt dem Teilnehmenden überlassen, sich um die obenstehenden Posten zu kümmern.'\
        +' Wir empfehlen dringend den Abschluss einer Reiserücktrittsversicherung.'

        pdf.move_down 3.mm
        text 'Weitere vertraglichen Pflichten', size: 12
        pdf.move_down 1.mm
        text 'Die*Der Teilnehmer*in muss sich um gültige Reisedokumente und Einreisegenehmigungen'\
        +' kümmern. Für deutsche Staatsangehörige heißt das, dass zur Einreise ein für die'\
        +' Dauer des Aufenthaltes gültiger Reisepass und die jeweilige Einreisegenehmigung'\
        +' (für Südkorea) erforderlich ist. Nicht deutsche Staatsbürger*innen informieren'\
        +' sich bitte rechtzeitig, welche Dokumente benötigt werden.'
        pdf.move_down 1.mm
        text 'Die, bei der Anmeldung abgefragten Daten zur Gesundheitsvorsorge müssen'\
        +' wahrheitsgemäß beantwortet werden. Für die gesundheitliche Betreuung steht'\
        +' während des Jamborees das Jamboree-Hospital (medizinische Erstversorgungseinrichtung)'\
        +' und nach Möglichkeit zwei deutschsprachige Kontingentsärzt*innen als'\
        +' Ansprechpartner*innen zur Verfügung. Die Einreichung des Gesundheitsbogens'\
        +' ist notwendig, da die medizinische Versorgung nur auf der Basis der vorliegenden'\
        +' Informationen übernommen werden kann.'
        pdf.move_down 1.mm
        text 'Außerplanmäßige Rückflüge sind aufgrund der großen Entfernung, außer bei'\
        +' ärztlich diagnostizierten medizinischen Notfällen, nicht möglich.'

        pdf.move_down 3.mm
        text 'Allgemeines', size: 12
        pdf.move_down 1.mm
        text 'Sonderabsprachen sind nur dann wirksam, wenn sie durch den rdp schriftlich'\
        +' bestätigt wurden. Mündliche Absprachen haben keine Rechtsgeltung. Die'\
        +' Unwirksamkeit einzelner Bestimmungen des Reisevertrags und der'\
        +' Teilnahmebedingungen hat nicht die Unwirksamkeit des gesamten Reisevertrags /'\
        +' Teilnahmebedingungen zur Folge. Unwirksame Bestimmungen werden durch solche'\
        +' ersetzt, die den angestrebten wirtschaftlichen Zweck möglichst weitgehend erreichen.'
        text ''
      end
      # rubocop:enable AbcSize,MethodLength
    end
    # rubocop:enable ClassLength
  end
end
