if (dir.exists(file.path(getwd(), "data"))) {
  val <- unlink(file.path(getwd(), "data"), recursive = TRUE)
  if (val == 1) {
    stop("directory was not deleted")
  } else {
    if (isFALSE(dir.exists(file.path(getwd(), "data")))) {
      message("data directory was successfully deleted")
    }
  }
}
