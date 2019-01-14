# Read data
raw_data <- read.csv('data/201804111738.csv')

file.copy('data/201804111738.csv', 'output/raw_data_201804111738.csv')
file.copy('prepare_data.R', 'output/prepare_data.R')

# Create output directory
dir.create('output', TRUE)

# Start with real data from id 36 on
raw_data <- subset(raw_data, id > 36)

# Mark row as completed
raw_data$completed <- raw_data$pan20 > 0

# Calculate the speed in minutes
raw_data$duration <- as.numeric(difftime(as.POSIXct(strptime(raw_data$updated_at, "%Y-%m-%d %H:%M")), as.POSIXct(strptime(raw_data$started_at, "%Y-%m-%d %H:%M"))))

# Questionary is completed when pan is filled out
completed <- subset(raw_data, completed == TRUE)


# Export data for panel provider
tic_list <- raw_data[,c('tic','group','completed','created_at', 'updated_at')]
write.csv(tic_list, file = 'output/tic_list.csv', row.names = F)

# Recode group to group number
completed$groupNumber <- NA

completed$groupNumber[completed$group == 'gj'] <- 1
completed$groupNumber[completed$group == 'ms'] <- 2
completed$groupNumber[completed$group == 'sb1'] <- 3
completed$groupNumber[completed$group == 'sb2'] <- 4

# Recode Emojis
completed$VA1_lo__VA1_hi <- 100 - completed$VA1_hi__VA1_lo
completed$PA1_lo__PA1_hi <- 100 - completed$PA1_hi__PA1_lo
completed$PA4_lo__PA4_hi <- 100 - completed$PA4_hi__PA4_lo3
completed$NA1_lo__NA1_hi <- 100 - completed$NA1_hi__NA1_lo
completed$NA4_lo__NA4_hi <- 100 - completed$NA4_hi__NA4_lo

# Recode MRS
# According Handbuch Fragebogen zur Erfassung der Persönlichkeit (MRS-30-R1) November 2017
#   6: sehr
#   5: ziemlich
#   4: eher
#   3: eher
#   2: ziemlich
#   1: sehr
# mrs1: gesprächig | schweigsam
# R mrs2: reizbar | gutmütig
# mrs3: gründlich | unsorgfältig
# R mrs4: verletzlich | robust
# mrs5: künstlerisch | unkünstlerisch
# R mrs6: zurückhaltend | kontaktfreudig
# mrs7: nachsichtig | barsch
# R mrs8: ungeordnet | geordnet
# mrs9: selbstzufrieden | selbstmitleidig
# R mrs10: unkreativ | kreativ
# mrs11: anschlussbedürftig | einzelgängerisch # Nicht in MRS-30 enthalten!
# R mrs12: selbstsüchtig | selbstlos
# mrs13: übergenau | ungenau # Nicht in MRS-30 enthalten!
# R mrs14: überempfindlich | entspannt
# mrs15: originell | konventionell # Nicht in MRS-30 enthalten!
# R mrs16: zurückgezogen | gesellig
# mrs17: friedfertig | streitsüchtig
# R mrs18: nachlässig | gewissenhaft
# mrs19: gefühlsstabil | labil
# R mrs20: phantasielos | phantasievoll
completed$mrs6r <- 7 - completed$mrs6
completed$mrs16r <- 7 - completed$mrs16
completed$mrs2r <- 7 - completed$mrs2
completed$mrs12r <- 7 - completed$mrs12
completed$mrs8r <- 7 - completed$mrs8
completed$mrs18r <- 7 - completed$mrs18
completed$mrs4r <- 7 - completed$mrs4
completed$mrs14r <- 7 - completed$mrs14
completed$mrs10r <- 7 - completed$mrs10
completed$mrs20r <- 7 - completed$mrs20

# Recode PANAVA
# According Kurzskalen zur Erfassung der Positiven Aktivierung, NegativenAktivierung und Valenz in Experience Sampling Studien (PANAVA-KS) Schallberger 2005
#   1: sehr
#   2: ziemlich
#   3: etwas
#   4: unentschieden
#   5: etwas
#   6: ziemlich
#   7: sehr
# R pnv1: zufrieden | unzufrieden
# R pnv2: energiegeladen | energielos
# Rpnv3: gestresst | entspannt
# pnv4: müde | hellwach
# pnv5: friedlich | verärgert
# pnv6: unglücklich | glücklich
# pnv7: lustlos | hoch motiviert
# pnv8: ruhig | nervös
# R pnv9: begeistert | gelangweilt
# R pnv10: besorgt | sorgenfrei
completed$pnv1r <- 8 - completed$pnv1
completed$pnv2r <- 8 - completed$pnv2
completed$pnv3r <- 8 - completed$pnv3
completed$pnv9r <- 8 - completed$pnv9
completed$pnv10r <- 8 - completed$pnv10

## Other Items
# who:
#   5: Die ganze Zeit
#   4: Meistens
#   3: Etwas mehr als die Hälfte der Zeit
#   2: Etwas weniger als die Hälfte der Zeit
#   1: Ab und zu
#   0: Zu keinem Zeitpunkt
# who1: In den letzten Tagen war ich froh und guter Laune
# who2: In den letzten Tagen habe ich mich ruhig und entspannt gefühlt
# who3: In den letzten Tagen habe ich mich energisch und aktiv gefühlt
# who4: In den letzten Tagen habe ich mich beim Aufwachen frisch und ausgeruht gefühlt
# who5: In den letzten Tagen war mein Alltag voller Dinge, die mich interessieren

# swl:
#   1: trifft überhaupt nicht zu
#   2: trifft nicht zu
#   3: trifft eher nicht zu
#   4: teils / teils
#   5: trifft eher zu
#   6: trifft zu
#   7: trifft vollständig zu
# swls1: In den meisten Bereichen entspricht mein Leben meinen Idealvorstellungen.
# swls2: Meine Lebensbedingungen sind ausgezeichnet.
# swls3: Ich bin mit meinem Leben zufrieden.
# swls4: Bisher habe ich die wesentlichen Dinge erreicht, die ich mir für mein Leben wünsche.
# swls5: Wenn ich mein Leben noch einmal leben könnte, würde ich kaum etwas ändern.

# pan:
#   1: gar nicht
#   2: ein bisschen
#   3: einigermassen
#   4: erheblich
#   5: äusserst
# pan1: aktiv
# pan2: bekümmert
# pan3: interessiert
# pan4: freudig erregt
# pan5: verärgert
# pan6: stark
# pan7: schuldig
# pan8: erschrocken
# pan9: feindselig
# pan10: angeregt
# pan11: stolz
# pan12: gereizt
# pan13: begeistert
# pan14: beschämt
# pan15: wach
# pan16: nervös
# pan17: entschlossen
# pan18: aufmerksam
# pan19: durcheinander
# pan20: ängstlich

# Aggregate data
completed$who <- rowMeans(completed[,grepl('who',names(completed))])
completed$swl <- rowMeans(completed[,grepl('swl',names(completed))])

completed$mrsEX <- rowMeans(completed[,c('mrs1','mrs6r', 'mrs11', 'mrs16r')])
completed$mrsVE <- rowMeans(completed[,c('mrs2r','mrs7', 'mrs12r', 'mrs17')])
completed$mrsGE <- rowMeans(completed[,c('mrs3','mrs8r', 'mrs13', 'mrs18r')])
completed$mrsEM <- rowMeans(completed[,c('mrs4r','mrs9', 'mrs14r', 'mrs19')])
completed$mrsKU <- rowMeans(completed[,c('mrs5','mrs10r', 'mrs15', 'mrs20r')])

completed$pnvPA <- rowMeans(completed[,c('pnv2r','pnv4', 'pnv7', 'pnv9r')])
completed$pnvNA <- rowMeans(completed[,c('pnv3r','pnv5', 'pnv8', 'pnv10r')])
completed$pnvVA <- rowMeans(completed[,c('pnv1r','pnv6')])

completed$EMJ_PA <- rowMeans(completed[,c('PA1_lo__PA1_hi','PA2_lo__PA2_hi1', 'PA3_lo__PA3_hi', 'PA4_lo__PA4_hi')])
completed$EMJ_NA <- rowMeans(completed[,c('NA1_lo__NA1_hi','NA2_lo__NA2_hi', 'NA3_lo__NA3_hi', 'NA4_lo__NA4_hi')])
completed$EMJ_VA <- rowMeans(completed[,c('VA1_lo__VA1_hi','VA2_lo__VA2_hi')])

completed$PANAS_PA <- rowMeans(completed[,c('pan1','pan3', 'pan4', 'pan6', 'pan10', 'pan11', 'pan13', 'pan15', 'pan17', 'pan18')])
completed$PANAS_VA <- rowMeans(completed[,c('pan2', 'pan5', 'pan7', 'pan8', 'pan9',  'pan12', 'pan14', 'pan19', 'pan19', 'pan20')])

# Rename .variables
library('plyr')
completed <- rename(completed,c('age'='Alter'))
completed <- rename(completed,c('gender'='Geschlecht'))
completed <- rename(completed,c('education'='Bildungsstand'))
completed <- rename(completed,c('residence'='Land'))
completed <- rename(completed,c('group'='Fragebogenversion'))
completed <- rename(completed,c('groupNumber'='Fragebogenversion Numerisch'))

completed <- rename(completed,c('sam1'='SAM Satisfaction'))
completed <- rename(completed,c('sam2'='SAM Dominance'))
completed <- rename(completed,c('sam3'='SAM Activation'))

# Recode .variables
library(car)
completed$Geschlecht <- as.factor(completed$Geschlecht)
completed$Geschlecht <- recode(completed$Geschlecht, "'f'='weiblich'; 'm'='männlich'; 'n'='Anderes'")
completed$Bildungsstand <- as.ordered(completed$Bildungsstand)
completed$Bildungsstand <- recode(completed$Bildungsstand, "
                                  0='Kein Abschluss'; 
                                  1='Hauptschul-/Volksschulabschlus'; 
                                  2='Obligatorische Schule (Primar-/Real-/Sekundar-/ Bezirksschule)';
                                  3='Berufslehre, Berufsschule, Berufsmittelschule';
                                  4='Maturität / Abitur';
                                  5='Fachhochschule';
                                  6='Universität, Hochschule'")

completed$Land <- as.factor(completed$Land)
completed$Land <- recode(completed$Land, "'ch'='Schweiz'; 'de'='Deutschland'; 'at'='Österreich'; 'others'='Anderes'")
completed$Fragebogenversion <- as.factor(completed$Fragebogenversion)
completed$Fragebogenversion <- recode(completed$Fragebogenversion, "'ms'='Version MS'; 'sb1'='Version Schallberger 1'; 'sb2'='Version Schallberger 2'; 'gj'='Version GJ'")

for(.variable in names(completed)[grepl('who',names(completed))]) {
  completed[,.variable] <- as.ordered(completed[,.variable])
  completed[,.variable] <- recode(completed[,.variable], "
                                 0='Zu keinem Zeitpunkt'; 
                                 1='Ab und zu'; 
                                 2='Etwas weniger als die Hälfte der Zeit'; 
                                 3='Etwas mehr als die Hälfte der Zeit'; 
                                 4='Meistens'; 
                                 5='Die ganze Zeit'")
}

for(.variable in names(completed)[grepl('swl',names(completed))]) {
  completed[,.variable] <- as.ordered(completed[,.variable])
  completed[,.variable] <- recode(completed[,.variable], "
                                 1='trifft überhaupt nicht zu'; 
                                 2='trifft nicht zu'; 
                                 3='trifft eher nicht zu'; 
                                 4='teils / teils'; 
                                 5='trifft eher zu';
                                 6='trifft zu';
                                 7='trifft vollständig zu';
                                 ")
}

for(.variable in names(completed)[grepl('pan',names(completed))]) {
  completed[,.variable] <- as.ordered(completed[,.variable])
  completed[,.variable] <- recode(completed[,.variable], "
                                 1='gar nicht'; 
                                 2='ein bisschen'; 
                                 3='einigermassen'; 
                                 4='erheblich'; 
                                 5='äusserst';
                                 ")
}

# Remove some unnecessary meta data
completed.skinny <- subset(completed, select = -c(visit_token, visitor_token, ip, user_agent, referrer, landing_page, referring_domain, search_keyword, browser, os, device_type, screen_height, screen_width, country, region, city, postal_code, latitude, longitude, utm_source, utm_medium, utm_term, utm_content, utm_campaign))

# Export data
write.csv(completed.skinny, file = 'output/201804111738_recoded.csv', row.names = F)
library('foreign')
write.dta(completed.skinny, file = 'output/201804111738_recoded.dta')
write.foreign(completed.skinny, datafile='output/201804111738_recoded.txt', codefile='output/201804111738_recoded.sps', package="SPSS")
library(xlsx)
write.xlsx2(completed.skinny, "output/201804111738_recoded.xlsx", row.names = F)
