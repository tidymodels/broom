context("sp tidiers")

library(sp)
library(rgeos)
library(maptools)

test_that("polygon tidiers work", {
    # tidy.Polygon
    Sr1 <- Polygon(cbind(c(2, 4, 4, 1, 2), c(2, 3, 5, 4, 2)))
    Sr2 <- Polygon(cbind(c(5, 4, 2, 5), c(2, 3, 2, 2)))
    Sr3 <- Polygon(cbind(c(4, 4, 5, 10, 4), c(5, 3, 2, 5, 5)))
    Sr4 <- Polygon(cbind(c(5, 6, 6, 5, 5), c(4, 4, 3, 3, 4)), hole = TRUE)

    td <- tidy(Sr1)
    check_tidy(td, exp.row = 5, exp.col = 4)

    # tidy.Polygons
    Srs1 <- Polygons(list(Sr1), "s1")
    Srs2 <- Polygons(list(Sr2), "s2")
    Srs3 <- Polygons(list(Sr3, Sr4), "s3/4")

    td <- tidy(Srs1)
    check_tidy(td, exp.row = 5, exp.col = 7)

    # tidy.SpatialPolygons
    SpP <- SpatialPolygons(list(Srs1, Srs2, Srs3), 1:3)

    td <- tidy(SpP)
    check_tidy(td, exp.row = 19, exp.col = 7)

    # tidy.SpatialPolygonsDataFrame
    grd <- GridTopology(c(1, 1), c(1, 1), c(10, 10))
    polys <- as(grd, "SpatialPolygons")
    centroids <- coordinates(polys)
    x <- centroids[, 1]
    y <- centroids[, 2]
    z <- 1.4 + 0.1 * x + 0.2 * y + 0.002 * x * x
    SpPDF <- SpatialPolygonsDataFrame(
        polys,
        data = data.frame(x = x, y = y, z = z, row.names = row.names(polys))
    )

    td <- tidy(SpPDF)
    check_tidy(td, exp.row = 500, exp.col = 7)

    td <- tidy(SpPDF, region = "x")
    check_tidy(td, exp.row = 230, exp.col = 7)
})

test_that("line tidiers work", {
    l1 <- cbind(c(1, 2, 3), c(3, 2, 2))
    rownames(l1) <- letters[1:3]
    l1a <- cbind(l1[, 1] + .05, l1[, 2] + .05)
    rownames(l1a) <- letters[1:3]
    l2 <- cbind(c(1, 2, 3), c(1, 1.5, 1))
    rownames(l2) <- letters[1:3]

    # tidy.Line
    Sl1 <- Line(l1)
    Sl1a <- Line(l1a)
    Sl2 <- Line(l2)

    td <- tidy(Sl1)
    check_tidy(td, exp.row = 3, exp.col = 3)

    # tidy.Lines
    S1 <- Lines(list(Sl1, Sl1a), ID = "a")
    S2 <- Lines(list(Sl2), ID = "b")

    td <- tidy(S1)
    check_tidy(td, exp.row = 6, exp.col = 6)

    # tidy.SpatialLinesDataFrame
    Sl <- SpatialLines(list(S1, S2))
    SlDF <- SpatialLinesDataFrame(
        Sl,
        data = data.frame(sp = c(5, 10), row.names = c("a", "b"))
    )

    td <- tidy(SlDF)
    check_tidy(td, exp.row = 9, exp.col = 6)
})
