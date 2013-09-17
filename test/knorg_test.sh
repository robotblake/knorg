export PREFIX="$(mktemp -t knorg -d)"
export PATH="$PWD/bin:$PATH"
export HOME="$PREFIX/home"

setUp() {
  mkdir -p "$HOME/.knives/personal"
  touch    "$HOME/.knives/personal/knife.rb"
  mkdir -p "$HOME/.knives/work-development"
  touch    "$HOME/.knives/work-development/knife.rb"
  mkdir -p "$HOME/.knives/work-production"
  touch    "$HOME/.knives/work-production/knife.rb"

  source "$PWD/knorg.sh"
}

tearDown() {
  rm -rf "$PREFIX"
  unset KNIFE_HOME
}

test_knorg_default_KNIVES() {
  assertEquals "did not correctly populate KNIVES" \
    "3" "${#KNIVES[@]}"
  assertEquals "did not correctly populate KNIVES" \
    "$HOME/.knives/personal" "${KNIVES[0]}"
  assertEquals "did not correctly populate KNIVES" \
    "$HOME/.knives/work-development" "${KNIVES[1]}"
  assertEquals "did not correctly populate KNIVES" \
    "$HOME/.knives/work-production" "${KNIVES[2]}"
}

test_knorg() {
  knorg personal

  assertEquals "did not set KNIFE_HOME to personal" \
    "$HOME/.knives/personal" "$KNIFE_HOME"
}

test_knorg_system() {
  knorg personal

  knorg system

  assertNull "did not unset KNIFE_HOME" "$KNIFE_HOME"
}

test_knorg_invalid() {
  rm "$HOME/.knives/personal/knife.rb"

  knorg personal 2>/dev/null

  assertEquals "did not return 1" 1 $?
  assertNull "did not ignore setting KNIFE_HOME" "$KNIFE_HOME"
}

test_knorg_unknown() {
  mkdir -p "$HOME/.knives/neworg"
  touch    "$HOME/.knives/neworg/knife.rb"

  knorg neworg 2>/dev/null

  assertEquals "did not return 1" 1 $?
  assertNull "did not ignore setting KNIFE_HOME" "$KNIFE_HOME"
}
