if (dir.exists(file.path(getwd(), "MadIsland", "data"))) {
  val <- unlink(file.path(getwd(), "MadIsland", "data"), recursive = TRUE)
  if (val == 1) {
    stop("directory was not deleted")
  } else {
    if (isFALSE(dir.exists(file.path(getwd(), "MadIsland", "data")))) {
      message("data directory was successfully deleted")
    }
  }
}
