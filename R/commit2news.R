commit2news <- function(repo_path = ".", min = 1, max = 999) {
  library(git2r)
  repo <- repository(repo_path)
  commits(repo) %>%
      map_chr(`[[`, "message") %>%
      .[min:max] %>%
      .[str_length(.)>0] %>%
      na.omit() %>%
      str_to_sentence() %>%
      paste("*", .) %>%
      str_replace_all("^\\* \\* ", "* ") %>%
      str_flatten("\n") %>%
      str_replace_all("\n+", "\n") %>%
      clipr::write_clip()
  # 选择多少到对少的 commits 来更新 NEWS.md
}
