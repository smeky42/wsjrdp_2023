# frozen_string_literal: true

#  Copyright (c) 2012-2021, German Contingent for the Worldscoutjamboree 2023. This file is part of
#  hitobito_wsjrdp_2023 and licensed under the Affero General Public License version 3
#  or later. See the COPYING file at the top-level directory or at
#  https://github.com/hitobito/hitobito_wsjrdp_2023.

module Wsjrdp2023
  module Export::Pdf::Registration
    # rubocop:disable Metrics/ClassLength
    class Travel < Section
      include FinanceHelper

      def render
        pdf.y = bounds.height - 60
        bounding_box([0, 230.mm], width: bounds.width, height: bounds.height - 200) do
          font_size(8) do
            text list, style: :italic, width: bounds.width
          end
        end
      end

      # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
      def list
        pdf.start_new_page
        text 'Teilnahme- und Reisebedingungen für die Teilnahme im Deutschen Kontingent zum 25. '\
        +'World Scout Jamboree 2023 in Südkorea', size: 14
        pdf.move_down 3.mm
        text 'v0.3 vom 28.07.2021'
        pdf.move_down 3.mm
        text '1. Veranstalter', size: 12
        pdf.move_down 1.mm
        text 'Ringe deutscher Pfadfinder*innenverbände e.V.(rdp),'
        text 'vertreten durch Joschka Hench, Sebastian Köngeter, Oliver Mahn, Naima Hartit '\
        +'und Susanne Rüber'
        text 'Chausseestraße 128/129'
        text '10115 Berlin'
        text 'Telefonnummer Büro: +49 30 288 7895 35'

        pdf.move_down 3.mm
        text '1.1 Organisation / Kontakt', size: 10
        pdf.move_down 1.mm
        text 'Organisatorischer Ansprechpartner ist neben dem Veranstalter, die Kontingentsleitung'\
        +' zum World Scout Jamboree 2023. Die Kontingentsleitung ist wie folgt zu erreichen:'
        # text 'Telefon: TODO Telefon?'
        text 'E-Mail: info@worldscoutjamboree.de'
        text 'Weitere Kontaktdaten finden sich auf der Homepage: www.worldscoutjamboree.de'

        pdf.move_down 3.mm
        text '2. Reisezeitraum', size: 12
        pdf.move_down 1.mm
        text 'Die Fahrt des rdp-Kontingents ist für den Zeitraum vom 20.07 bis 21.08.2023'\
        +' geplant. Der Reisezeitraum variiert je nach gewähltem Paket und Lage der'\
        +' Sommerferien, Reisedauer sind 13 bis 25 Tage. Die genauen Reisedaten'\
        +' werden im Herbst 2022 feststehen, da erst zu diesem Zeitpunkt die tatsächlichen'\
        +' Flugdaten festgelegt werden können. Die Teilnehmenden werden über die,'\
        +' in der Anmeldung angegebenen Mailadressen über die Reisedaten informiert.'

        pdf.move_down 3.mm
        text '3. Reiseziel, Reiseform, Pakete', size: 12
        pdf.move_down 1.mm
        text '3.1 Das Reiseland ist die Republik Korea (Südkorea). Nach Abschluss der Planung'\
        +' werden genaue Reisedetails bekannt gegeben.'
        pdf.move_down 1.mm
        text '3.2 Die Teilnahme am World Scout Jamboree 2023 unterscheidet sich je nach Rolle'\
        +' des Teilnehmers im Deutschen Kontingent. Es gibt jeweils Reisepakete für:'

        pdf.move_down 3.mm
        pdf.indent(10) do
          text 'a) Teilnehmende in Units (Unitleiter*innen und Teilnehmer*innen)'
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
          text 'b) Kontingentsteam (KT), Kontingentsleitung (KL + eKL) und International Service'\
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
        text '4. Teilnahmebedingungen', size: 12
        pdf.move_down 1.mm
        text '4.1 Teilnehmer*innen müssen zwischen dem 22.07.2005 und dem 31.07.2009 geboren'\
        +'  sein. Erwachsene können nur als Unit- oder Kontingentsleitung, als'\
        +' Kontingentsteammitglied oder als Mitglied des International Service'\
        +' Teams (IST) am Jamboree teilnehmen und damit die Durchführung unterstützen.'
        pdf.move_down 1.mm
        text '4.2 Eine aktive Mitgliedschaft in einem der folgenden Pfadfinder*innenverbände'\
        +' ist Voraussetzung für die Teilnahme:'
        pdf.move_down 1.mm
        text '- Bund der Pfadfinderinnen und Pfadfinder (BdP),
        - Bund Moslemischer Pfadfinder und Pfadfinderinnen Deutschlands e.V. (BMPPD),
        - Deutsche Pfadfinderschaft Sankt Georg (DPSG),
        - Pfadfinderinnenschaft Sankt Georg (PSG),
        - Verband Christlicher Pfadfinderinnnen und Pfadfinder (VCP).'
        pdf.move_down 1.mm
        text '4.3 Die Teilnahme am Jamboree setzt voraus, dass der Teilnehmer an'\
        +' mindestens zwei Vorbereitungstreffen teilnimmt. Die Daten zu den Vorbereitungstreffen'\
        +' werden den Teilnehmer*innen von der jeweiligen Betreuung bekannt gegeben.'
        pdf.move_down 1.mm
        text '4.4 Die*Der Teilnehmer*in ist selbst dafür verantwortlich, die erforderlichen'\
        +' Reisedokumente und Einreisegenehmigungen zu beschaffen. Deutsche Staatsangehörige'\
        +' benötigen für die Einreise einen für die Dauer des Aufenthaltes gültigen Reisepass'\
        +' und die jeweilige Einreisegenehmigung (für Südkorea). Nicht deutsche Staatsbürger*innen'\
        +' informieren sich bitte rechtzeitig, welche Dokumente sie benötigen.'
        pdf.move_down 1.mm
        text '4.5 Für die gesundheitliche Betreuung steht während des Jamborees das'\
        +' Jamboree-Hospital (medizinische Erstversorgungseinrichtung) und nach Möglichkeit'\
        +' zwei deutschsprachige Kontingentsärzt*innen als Ansprechpartner*innen zur Verfügung.'\
        +' Außerplanmäßige Rückflüge sind aufgrund der großen Entfernung, außer bei ärztlich'\
        +' diagnostizierten medizinischen Notfällen, nicht möglich.'

        text '5. Anfertigung von Bild- und Tonaufnahmen', size: 12
        pdf.move_down 3.mm
        text '5.1 Der rdp wird die Veranstaltung und die Vorbereitungstreffen mit Bild- und'\
        + ' Tonaufnahmen dokumentieren. Die Parteien vereinbaren in diesem Zusammenhang,'\
        + ' dass Fotografen, die vom Veranstalter ausgewählt und beauftragt werden,'\
        + ' Lichtbilder des Teilnehmers aufnehmen dürfen.'
        text '5.2 Für die Aufnahme und Nutzung wird keine inhaltliche, zeitliche oder'\
        + ' räumliche Beschränkung vereinbart. Zulässig ist die Nutzung insbesondere für'\
        + ' folgende Zwecke:'
        pdf.indent(10) do
          text '
           • Veröffentlichung in den Medien der Mitgliedsverbände (z.B. Zeitschrift, Newsletter)
           • Veröffentlichung in der Presse (z.B. Pressefotos)
           • Veröffentlichung im Internet (z.B. auf den Homepages des Veranstalters oder eines '\
        +'Mitgliedsverbands oder den jeweiligen Auftritten bei Facebook, Instagramm  etc.)
           • Veröffentlichung in Werbemedien des Veranstalters oder eines Mitgliedsverbands '\
        +'(z.B. Flyer/Plakate)'
        end
        pdf.move_down 2.mm
        text '5.3 Der rdp ist berechtigt, die Aufnahmen innerhalb von Fotomontagen unter'\
        + ' Entfernung oder Ergänzung von Bildbestandteilen bzw. für verfremdete Bilder'\
        + ' (keine Entstellung) der Originalaufnahmen zu benutzen'
        pdf.move_down 1.mm
        text '5.4 Der rdp ist berechtigt, aber nicht verpflichtet, die Aufnahmen den'\
        + ' Mitgliedsverbänden unentgeltlich für die in 5.2 aufgezählten Zwecke zur'\
        + ' Verfügung zu stellten.'
        pdf.move_down 1.mm
        text '5.5 Der Teilnehmer überträgt dem rdp alle Rechte, die zur Ausübung der in'\
        + ' Ziff. 5.2 bis 5.4 aufgeführten Nutzungsrechte erforderlich sind. Die'\
        + ' Übertragung erfolgt örtlich und zeitlich unbeschränkt, unwiderruflich'\
        + ' und nicht ausschließlich. Eine gesonderte Vergütung erfolgt nicht.'
        pdf.move_down 1.mm
        text '5.6 Sollte ein Teilnehmer nicht gefilmt oder fotografiert werden wollen, so'\
        + ' soll er die jeweiligen Betreuer*innen hierauf jeweils vor Beginn der'\
        + ' Veranstaltung hinweisen. Der*Die Betreuer*in wird sich in diesem Fall'\
        + ' darum bemühen, die Fotografen darauf hinzuweisen, dass der Betroffene'\
        + ' nicht abgebildet werden möchte. Ein Erfolg kann nicht garantiert werden'\
        + ' und ist nicht geschuldet.'
        pdf.move_down 1.mm
        text '5.7 Bei Fragen zu der Anfertigung von Bild- und Tonaufnahmen und zu deren'\
        + ' Verwendung kann sich der Teilnehmer an die Email-Adresse'\
        + ' media-info@worldscoutjamboree.de wenden.'

        pdf.move_down 3.mm
        text '6. Anmeldung und Vertragsschluss', size: 12
        pdf.move_down 1.mm
        text '6.1 Die Anmeldung ist bis zum 01.11.2021 über die Homepage'\
        +' anmeldung.worldscoutjamboree.de möglich. Während des Online-Anmeldeprozesses wird'\
        +' eine PDF-Dokument generiert, das die anmeldende Person lesen und akzeptieren muss.'\
        +' Das Anmeldungsdokument muss unterschrieben werden und spätestens bis zum Anmeldeschluss'\
        +' am 01.10.2021 über die Homepage hochgeladen werden. Die Anmeldung muss im Original'\
        +' (Papierform mit Unterschriften) spätestens zum 01.06.2022 bei den entsprechenden'\
        +'  Betreuer*innen (UL, IST-Betreuung, eKL) abgegeben werden.'
        text 'Bei Personen, die zum Zeitpunkt der Anmeldung das 18. Lebensjahr noch nicht'\
        +' vollendet haben, muss die Anmeldung durch alle gesetzlichen Vertreter*innen'\
        +' unterzeichnet sein.'
        pdf.move_down 1.mm
        text '6.2 Ein Vertrag über die Teilnahme kommt erst dann zustande, wenn der rdp die'\
        +' Anmeldung in Textform (z.B. E-Mail) bestätigt. Dies erfolgt erst nach Anmeldeschluss.'

        pdf.move_down 3.mm
        text '7. Teilnahmebeitrag, Preiserhöhungen, Änderung der Reisebedingungen', size: 12
        pdf.move_down 1.mm
        text '7.1 Der Teilnahmebetrag richtet sich nach der gewählten Teilnahmevariante'\
        +' (s.o. Ziff. 3.2, Reiseform und Pakete) und ggf. nach der Funktion des Teilnehmers im'\
        +' Kontingent. '

        pdf.move_down 3.mm
        text 'Das SEPA Lastschriftverfahren wird nach folgendem Plan eingezogen.'\
       + ' Der Einzug erfolgt am 5. des jeweigen Monats bzw. am darauf folgenden Werktag.'

        pdf.move_down 3.mm
        pdf.make_table(payment_array, cell_style: { padding: 1, border_width: 0,
                                                    inline_format: true, size: 6 }).draw
        pdf.move_down 3.mm
        text 'NICHT im Teilnahmebeitrag enthalten sind:'
        pdf.move_down 1.mm
        text '- Reiserücktrittversicherung
        - Gepäckversicherung
        - persönliche Ausgaben
        - Kosten für Einreisegenehmigungen nach Korea'
        pdf.move_down 1.mm
        text 'Der Abschluss einer Reiserücktrittsversicherung wird dringend empfohlen.'
        pdf.move_down 1.mm
        text '7.2 Sollten sich nach Bestätigung der Anmeldung durch den rdp wesentliche Umstände'\
        +' ändern, insbesondere Beförderungskosten, Flughafengebühren, Steuern oder'\
        +' Wechselkurse, oder sollten sonstige Änderungen am Programm vorgenommen werden'\
        +' müssen, behält sich der rdp vor, den Teilnahmebeitrag um den jeweiligen Erhöhungsbetrag'\
        +' anzupassen. Ab dem 20. Tag vor Reiseantritt ist eine Preiserhöhung unzulässig.'\
        +' Überschreitet der Erhöhungsbetrag 5 % des ursprünglich vereinbarten Preises,'\
        +' ist der Teilnehmer nach Maßgabe von Ziff. 8.3 berechtigt, vom Vertrag zurückzutreten.'
        pdf.move_down 1.mm
        text '7.3 Der Beitrag kann nur durch SEPA-Lastschriften entrichtet werden. Hierfür ist'\
        +' die Erteilung eines SEPA-Basis-Lastschriftmandates erforderlich.'
        pdf.move_down 1.mm

        pdf.move_down 3.mm
        text '8. Rücktritt des Teilnehmers vor Leistungsbeginn ', size: 12
        pdf.move_down 1.mm
        text '8.1 Der Teilnehmer kann jederzeit vor Beginn der Reise von dem Vertrag zurücktreten.'\
        +' Der Rücktritt ist schriftlich gegenüber dem rdp zu erklären. '
        pdf.move_down 1.mm
        text '8.2 Erklärt der Teilnehmer den Rücktritt, so verliert der rdp den Anspruch auf'\
        +' Zahlung des Teilnehmerbeitrages. Stattdessen kann der rdp eine angemessene'\
        +' Entschädigung verlangen, sofern der Rücktritt nicht von ihm zu vertreten'\
        +' ist. Die Höhe der Entschädigung ist pauschaliert wie folgt:'
        pdf.move_down 1.mm
        text '
          - bei Rücktritt bis zum 31.05.2022: 300,00 €,
          - bei Rücktritt bis zum 30.09.2022: 25% des Teilnahmebeitrags,
          - bei Rücktritt bis zum 31.12.2022: 50% des Teilnahmebeitrags,
          - bei Rücktritt bis zum 31.03.2023: 75% des Teilnahmebeitrags,
          - nach diesem Zeitpunkt in Höhe des vollen Teilnahmebeitrags'
        pdf.move_down 1.mm
        text 'Dem Teilnehmer bleibt der Nachweis unbenommen, dem rdp'\
        +' sei durch den Rücktritt kein Schaden entstanden oder der Schaden sei wesentlich'\
        +' geringer als die oben genannten Pauschalsätze.'
        pdf.move_down 1.mm
        text '8.3 Wenn der rdp von der ihm eingeräumten Möglichkeit Gebrauch macht, den'\
        +' Teilnahmebeitrag um mehr als 5 % gegenüber dem ursprünglich geltenden Preis'\
        +' zu erhöhen, und erklärt der Teilnehmer deshalb den Rücktritt, ist eine'\
        +' Entschädigung nicht geschuldet; der Teilnehmer schuldet aber Ausgleich für'\
        +' Teilleistungen, die er bis zum Rücktritt in Anspruch genommen hat. Das gleiche'\
        +' gilt für den Fall, dass der Teilnehmer mit ergänzenden Bedingungen, die der'\
        +' rdp aufgrund von Vorgaben des koreanischen Veranstalters weiterreichen muss,'\
        +' nicht einverstanden ist.'
        pdf.move_down 1.mm
        text '8.4 Der rdp behält sich das Recht vor, anstelle der Entschädigung nach'\
        +' Ziff. 8.2 Schadensersatz zu verlangen, soweit er nachweisen kann, dass'\
        +' aufgrund des Rücktritts oder des Nichtantritts der Reise wesentlich'\
        +' höhere Aufwendungen oder ein wesentlich höherer Schaden entstanden sind.'

        pdf.move_down 3.mm
        text '9. Kündigung und Rücktritt durch den rdp', size: 12
        pdf.move_down 1.mm
        text '9.1 Der rdp ist berechtigt, den Vertrag ohne Einhaltung einer Frist'\
        +' zu kündigen, wenn der Teilnehmer nachhaltig gegen seine im Reisevertrag'\
        +' und diesen Reisebedingungen vereinbarten Pflichten verstößt oder sonst'\
        +' durch sein Verhalten die Durchführung und den Erfolg der Veranstaltung'\
        +' nachhaltig gefährdet. Das ist insbesondere der Fall,'
        text '-	wenn der Teilnehmer entgegen 4.3 bei mehr als zwei Vorbereitungstreffen'\
        +' unentschuldigt gefehlt hat, oder'
        text '- wenn der Teilnehmer gegen die Satzung seines Mitgliedsverbandes '\
        + ' 4.2 verstößt, die Mitgliedschaft aufgibt oder sie verliert '
        text 'Die Kündigung ist nur zulässig, wenn der rdp den Teilnehmer zuvor in'\
        +' Textform (z.B. durch eine Email) abgemahnt hat und der Teilnehmer sein'\
        +' Fehlverhalten dennoch fortsetzt. Eine vorherige Abmahnung ist nicht'\
        +' erforderlich in Fällen gröbsten Fehlverhaltens, in denen eine sofortige'\
        +' Aufhebung des Vertrages auch unter Berücksichtigung der Interessen des'\
        +' Teilnehmers gerechtfertigt ist.'
        pdf.move_down 1.mm
        text '9.2 Der rdp ist zur Kündigung des Vertrages weiter dann berechtigt,'\
        +' wenn Lastschriften nicht eingelöst werden oder ihnen widersprochen wurde'\
        +' und auch nach schriftlicher Mahnung der fällige Teil des Teilnahmebeitrags'\
        +' nicht innerhalb von zwei Wochen bezahlt wird.'
        pdf.move_down 1.mm
        text '9.3 Im Falle der Kündigung nach Ziff. 9.1 und 9.2 behält der rdp den'\
        +' Anspruch auf den Teilnahmebeitrag. Er muss sich jedoch den Wert ersparter'\
        +' Aufwendungen sowie die Vorteile anrechnen lassen, die aus einer anderen'\
        +' Verwendung nicht in Anspruch genommener Leistungen erlangt werden, einschließlich'\
        +' evtl. erlangter Erstattungen durch Leistungsträger. Die Geltendmachung von weiterem'\
        +' Schadensersatz bleibt vorbehalten; dies gilt insbesondere für Mehrkosten für die'\
        +' Rückbeförderung des Teilnehmers.'
        pdf.move_down 1.mm
        text '9.4 Der rdp behält sich vor, in folgenden Fällen vom Vertrag zurückzutreten:'
        text 'a) Absage des Jamborees durch den koreanischen Veranstalter (The Organizing'\
        +' Committee for the 25th World Scout Jamboree - 2023 SaeManGeum,'\
        +' 301, 28 Saemunan-ro 5ga-gil, Jongno-gu, Seoul, Republic of Korea)'
        text 'b) höhere Gewalt; hierzu zählen auch Einreise- bzw. Ausreisebeschränkungen sowie'\
        +' sonstige staatliche Anordnungen im Zusammenhang mit der Ausbreitung des Virus SARS-CoV-2'
        text 'Im Falle des Rücktritts verliert der rdp den Anspruch auf den Teilnahmebeitrag.'\
        +' Er kann jedoch vom Teilnehmer eine angemessene Entschädigung bis zur Höhe der ihm'\
        +' bis zum Rücktritt entstandenen Kosten und Aufwendungen (z.B. für bereits erworbene'\
        +' Flugtickets) verlangen.'


        pdf.move_down 3.mm
        text '10. Schlussbestimmungen', size: 12
        pdf.move_down 1.mm
        text '10.1 Die Vertragsdurchführung unterliegt ausschließlich deutschem Recht.'
        pdf.move_down 1.mm
        text '10.2 Änderungen des Vertrages bedürfen der Schriftform. Mündliche Nebenabreden'\
        +' sind nicht getroffen.'
        pdf.move_down 1.mm
        text '10.3 Sollten einzelne Bestimmungen des Vertrages oder der vorliegenden'\
        +' Reisebedingungen unwirksam oder nichtig sein oder werden, so wird die Wirksamkeit'\
        +' des Vertrages und der übrigen Bedingungen hiervon nicht berührt. Die Parteien werden'\
        +' in einem solchen Fall unter Berücksichtigung des Gesetzes eine Vereinbarung'\
        +' treffen, die der unwirksamen oder nichtigen Klausel wirtschaftlich nahekommt.'\
        +' Das gleiche soll für den Fall gelten, dass im Vertrag eine Regelungslücke'\
        +' offenbar wird.'
        text ''
      end
      # rubocop:enable Metrics/AbcSize,Metrics/MethodLength
    end
    # rubocop:enable Metrics/ClassLength
  end
end
