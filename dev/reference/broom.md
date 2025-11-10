# broom: Convert Statistical Objects into Tidy Tibbles

Convert statistical analysis objects from R into tidy tibbles, so that
they can more easily be combined, reshaped and otherwise processed with
tools like dplyr, tidyr and ggplot2. The package provides three S3
generics: tidy, which summarizes a model's statistical findings such as
coefficients of a regression; augment, which adds columns to the
original data such as predictions, residuals and cluster assignments;
and glance, which provides a one-row summary of model-level statistics.

## See also

Useful links:

- <https://broom.tidymodels.org/>

- <https://github.com/tidymodels/broom>

- Report bugs at <https://github.com/tidymodels/broom/issues>

## Author

**Maintainer**: Simon Couch <simon.couch@posit.co>
([ORCID](https://orcid.org/0000-0001-5676-5107))

Authors:

- David Robinson <admiral.david@gmail.com>

- Alex Hayes <alexpghayes@gmail.com>
  ([ORCID](https://orcid.org/0000-0002-4985-5160))

Other contributors:

- Posit Software, PBC ([ROR](https://ror.org/03wc8by49)) \[copyright
  holder, funder\]

- Indrajeet Patil <patilindrajeet.science@gmail.com>
  ([ORCID](https://orcid.org/0000-0003-1995-6531)) \[contributor\]

- Derek Chiu <dchiu@bccrc.ca> \[contributor\]

- Matthieu Gomez <mattg@princeton.edu> \[contributor\]

- Boris Demeshev <boris.demeshev@gmail.com> \[contributor\]

- Dieter Menne <dieter.menne@menne-biomed.de> \[contributor\]

- Benjamin Nutter <nutter@battelle.org> \[contributor\]

- Luke Johnston <luke.johnston@mail.utoronto.ca> \[contributor\]

- Ben Bolker <bolker@mcmaster.ca> \[contributor\]

- Francois Briatte <f.briatte@gmail.com> \[contributor\]

- Jeffrey Arnold <jeffrey.arnold@gmail.com> \[contributor\]

- Jonah Gabry <jsg2201@columbia.edu> \[contributor\]

- Luciano Selzer <luciano.selzer@gmail.com> \[contributor\]

- Gavin Simpson <ucfagls@gmail.com> \[contributor\]

- Jens Preussner <jens.preussner@mpi-bn.mpg.de> \[contributor\]

- Jay Hesselberth <jay.hesselberth@gmail.com> \[contributor\]

- Hadley Wickham <hadley@posit.co> \[contributor\]

- Matthew Lincoln <matthew.d.lincoln@gmail.com> \[contributor\]

- Alessandro Gasparini <ag475@leicester.ac.uk> \[contributor\]

- Lukasz Komsta <lukasz.komsta@umlub.pl> \[contributor\]

- Frederick Novometsky \[contributor\]

- Wilson Freitas \[contributor\]

- Michelle Evans \[contributor\]

- Jason Cory Brunson <cornelioid@gmail.com> \[contributor\]

- Simon Jackson <drsimonjackson@gmail.com> \[contributor\]

- Ben Whalley <ben.whalley@plymouth.ac.uk> \[contributor\]

- Karissa Whiting <karissa.whiting@gmail.com> \[contributor\]

- Yves Rosseel <yrosseel@gmail.com> \[contributor\]

- Michael Kuehn <mkuehn10@gmail.com> \[contributor\]

- Jorge Cimentada <cimentadaj@gmail.com> \[contributor\]

- Erle Holgersen <erle.holgersen@gmail.com> \[contributor\]

- Karl Dunkle Werner ([ORCID](https://orcid.org/0000-0003-0523-7309))
  \[contributor\]

- Ethan Christensen <christensen.ej@gmail.com> \[contributor\]

- Steven Pav <shabbychef@gmail.com> \[contributor\]

- Paul PJ <pjpaul.stephens@gmail.com> \[contributor\]

- Ben Schneider <benjamin.julius.schneider@gmail.com> \[contributor\]

- Patrick Kennedy <pkqstr@protonmail.com> \[contributor\]

- Lily Medina <lilymiru@gmail.com> \[contributor\]

- Brian Fannin <captain@pirategrunt.com> \[contributor\]

- Jason Muhlenkamp <jason.muhlenkamp@gmail.com> \[contributor\]

- Matt Lehman \[contributor\]

- Bill Denney <wdenney@humanpredictions.com>
  ([ORCID](https://orcid.org/0000-0002-5759-428X)) \[contributor\]

- Nic Crane \[contributor\]

- Andrew Bates \[contributor\]

- Vincent Arel-Bundock <vincent.arel-bundock@umontreal.ca>
  ([ORCID](https://orcid.org/0000-0003-2042-7063)) \[contributor\]

- Hideaki Hayashi \[contributor\]

- Luis Tobalina \[contributor\]

- Annie Wang <anniewang.uc@gmail.com> \[contributor\]

- Wei Yang Tham <weiyang.tham@gmail.com> \[contributor\]

- Clara Wang <clara.wang.94@gmail.com> \[contributor\]

- Abby Smith <als1@u.northwestern.edu>
  ([ORCID](https://orcid.org/0000-0002-3207-0375)) \[contributor\]

- Jasper Cooper <jaspercooper@gmail.com>
  ([ORCID](https://orcid.org/0000-0002-8639-3188)) \[contributor\]

- E Auden Krauska <krauskae@gmail.com>
  ([ORCID](https://orcid.org/0000-0002-1466-5850)) \[contributor\]

- Alex Wang <x249wang@uwaterloo.ca> \[contributor\]

- Malcolm Barrett <malcolmbarrett@gmail.com>
  ([ORCID](https://orcid.org/0000-0003-0299-5825)) \[contributor\]

- Charles Gray <charlestigray@gmail.com>
  ([ORCID](https://orcid.org/0000-0002-9978-011X)) \[contributor\]

- Jared Wilber \[contributor\]

- Vilmantas Gegzna <GegznaV@gmail.com>
  ([ORCID](https://orcid.org/0000-0002-9500-5167)) \[contributor\]

- Eduard Szoecs <eduardszoecs@gmail.com> \[contributor\]

- Frederik Aust <frederik.aust@uni-koeln.de>
  ([ORCID](https://orcid.org/0000-0003-4900-788X)) \[contributor\]

- Angus Moore <angusmoore9@gmail.com> \[contributor\]

- Nick Williams <ntwilliams.personal@gmail.com> \[contributor\]

- Marius Barth <marius.barth.uni.koeln@gmail.com>
  ([ORCID](https://orcid.org/0000-0002-3421-6665)) \[contributor\]

- Bruna Wundervald <brunadaviesw@gmail.com>
  ([ORCID](https://orcid.org/0000-0001-8163-220X)) \[contributor\]

- Joyce Cahoon <joyceyu48@gmail.com>
  ([ORCID](https://orcid.org/0000-0001-7217-4702)) \[contributor\]

- Grant McDermott <grantmcd@uoregon.edu>
  ([ORCID](https://orcid.org/0000-0001-7883-8573)) \[contributor\]

- Kevin Zarca <kevin.zarca@gmail.com> \[contributor\]

- Shiro Kuriwaki <shirokuriwaki@gmail.com>
  ([ORCID](https://orcid.org/0000-0002-5687-2647)) \[contributor\]

- Lukas Wallrich <lukas.wallrich@gmail.com>
  ([ORCID](https://orcid.org/0000-0003-2121-5177)) \[contributor\]

- James Martherus <james@martherus.com>
  ([ORCID](https://orcid.org/0000-0002-8285-3300)) \[contributor\]

- Chuliang Xiao <cxiao@umich.edu>
  ([ORCID](https://orcid.org/0000-0002-8466-9398)) \[contributor\]

- Joseph Larmarange <joseph@larmarange.net> \[contributor\]

- Max Kuhn <max@posit.co> \[contributor\]

- Michal Bojanowski <michal2992@gmail.com> \[contributor\]

- Hakon Malmedal <hmalmedal@gmail.com> \[contributor\]

- Clara Wang \[contributor\]

- Sergio Oller <sergioller@gmail.com> \[contributor\]

- Luke Sonnet <luke.sonnet@gmail.com> \[contributor\]

- Jim Hester <jim.hester@posit.co> \[contributor\]

- Ben Schneider <benjamin.julius.schneider@gmail.com> \[contributor\]

- Bernie Gray <bfgray3@gmail.com>
  ([ORCID](https://orcid.org/0000-0001-9190-6032)) \[contributor\]

- Mara Averick <mara@posit.co> \[contributor\]

- Aaron Jacobs <atheriel@gmail.com> \[contributor\]

- Andreas Bender <bender.at.R@gmail.com> \[contributor\]

- Sven Templer <sven.templer@gmail.com> \[contributor\]

- Paul-Christian Buerkner <paul.buerkner@gmail.com> \[contributor\]

- Matthew Kay <mjskay@umich.edu> \[contributor\]

- Erwan Le Pennec <lepennec@gmail.com> \[contributor\]

- Johan Junkka <johan.junkka@umu.se> \[contributor\]

- Hao Zhu <haozhu233@gmail.com> \[contributor\]

- Benjamin Soltoff <soltoffbc@uchicago.edu> \[contributor\]

- Zoe Wilkinson Saldana <zoewsaldana@gmail.com> \[contributor\]

- Tyler Littlefield <tylurp1@gmail.com> \[contributor\]

- Charles T. Gray <charlestigray@gmail.com> \[contributor\]

- Shabbh E. Banks \[contributor\]

- Serina Robinson <robi0916@umn.edu> \[contributor\]

- Roger Bivand <Roger.Bivand@nhh.no> \[contributor\]

- Riinu Ots <riinuots@gmail.com> \[contributor\]

- Nicholas Williams <ntwilliams.personal@gmail.com> \[contributor\]

- Nina Jakobsen \[contributor\]

- Michael Weylandt <michael.weylandt@gmail.com> \[contributor\]

- Lisa Lendway <llendway@macalester.edu> \[contributor\]

- Karl Hailperin <khailper@gmail.com> \[contributor\]

- Josue Rodriguez <jerrodriguez@ucdavis.edu> \[contributor\]

- Jenny Bryan <jenny@posit.co> \[contributor\]

- Chris Jarvis <Christopher1.jarvis@gmail.com> \[contributor\]

- Greg Macfarlane <gregmacfarlane@gmail.com> \[contributor\]

- Brian Mannakee <bmannakee@gmail.com> \[contributor\]

- Drew Tyre <atyre2@unl.edu> \[contributor\]

- Shreyas Singh <shreyas.singh.298@gmail.com> \[contributor\]

- Laurens Geffert <laurensgeffert@gmail.com> \[contributor\]

- Hong Ooi <hongooi@microsoft.com> \[contributor\]

- Henrik Bengtsson <henrikb@braju.com> \[contributor\]

- Eduard Szocs <eduardszoecs@gmail.com> \[contributor\]

- David Hugh-Jones <davidhughjones@gmail.com> \[contributor\]

- Matthieu Stigler <Matthieu.Stigler@gmail.com> \[contributor\]

- Hugo Tavares <hm533@cam.ac.uk>
  ([ORCID](https://orcid.org/0000-0001-9373-2726)) \[contributor\]

- R. Willem Vervoort <Willemvervoort@gmail.com> \[contributor\]

- Brenton M. Wiernik <brenton@wiernik.org> \[contributor\]

- Josh Yamamoto <joshuayamamoto5@gmail.com> \[contributor\]

- Jasme Lee \[contributor\]

- Taren Sanders <taren.sanders@acu.edu.au>
  ([ORCID](https://orcid.org/0000-0002-4504-6008)) \[contributor\]

- Ilaria Prosdocimi <prosdocimi.ilaria@gmail.com>
  ([ORCID](https://orcid.org/0000-0001-8565-094X)) \[contributor\]

- Daniel D. Sjoberg <danield.sjoberg@gmail.com>
  ([ORCID](https://orcid.org/0000-0003-0862-2018)) \[contributor\]

- Alex Reinhart <areinhar@stat.cmu.edu>
  ([ORCID](https://orcid.org/0000-0002-6658-514X)) \[contributor\]
