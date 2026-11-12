class Onetree < Formula
  desc "Worktree per agent task, guarded main checkouts, cleanup when the PR merges"
  homepage "https://github.com/aditya-jha/onetree"
  url "https://github.com/aditya-jha/onetree/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "98e1c786212edc9c9ecb917a02c8262a2f0c06fde9645f17ab0af9294425b5df"
  license "MIT"

  depends_on "gh"
  depends_on "jq"

  def install
    # the whole tree: `onetree ui` reads ui/server.ts and ui/dist next to the script
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/onetree"
  end

  def caveats
    <<~EOS
      To set up the agent hooks, rules and the hourly cleanup job, run:
        #{opt_bin}/onetree install
      then check it with: onetree doctor
      After each `brew upgrade onetree`, run that install again.
    EOS
  end

  test do
    assert_equal "onetree #{version}", shell_output("#{bin}/onetree version").strip
  end
end
