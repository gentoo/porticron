#! /usr/bin/env bats
# Copyright (C) 2017 Sebastian Pipping <sebastian@pipping.org>
# Licensed under the 3-Clause BSD license

_clear_state() {
    rm -f /var/tmp/porticron.UPGRADE_MSG
    rm -f /var/tmp/porticron.DIFF_MSG
}


setup() { _clear_state ; }

teardown() { _clear_state ; }


PORTICRON() {
    DATE="$(cat test/data/date-r-output.txt)" \
    EMERGE=test/mocks/emerge \
        PORTDIR=/usr/portage \
        GLSA_CHECK=/bin/true \
        SENDMAIL=${SENDMAIL:-/bin/true} \
        bin/porticron \
        -c /dev/null \
        "$@"
}


@test "Test emerge output goes into e-mail" {
    output="$(SENDMAIL=cat PORTICRON)"
    diff -u <(echo "${output}") test/data/expected-sendmail-input.txt
}


@test "Test no mail on matching hashes" {
    output="$(PORTICRON -v 2>&1)"
    diff -u <(echo "${output}") test/data/expected-porticron-v-output-fresh.txt

    output="$(SENDMAIL=/bin/false PORTICRON -v 2>&1)"
    diff -u <(echo "${output}") test/data/expected-porticron-v-output-unchanged.txt
}
