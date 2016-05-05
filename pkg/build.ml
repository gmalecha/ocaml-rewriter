#!/usr/bin/env ocaml
#directory "pkg"
#use "topkg.ml"

let ocamlbuild =
  "ocamlbuild -use-ocamlfind -classic-display -plugin-tag 'package(cppo_ocamlbuild)'"

let () =
  let oc = open_out "src_test/_tags" in
  output_string oc (if Env.native then "<*.ml>: ppx_native" else "<*.ml>: ppx_byte");
  close_out oc

let () =
  Pkg.describe "ppx_rewrite" ~builder:(`Other (ocamlbuild, "_build")) [
    Pkg.lib "pkg/META";
    Pkg.bin ~auto:true "src/ppx_rewrite" ~dst:"../lib/ppx_rewrite/ppx_rewrite";
    Pkg.doc "README.md";
    Pkg.doc "LICENSE.txt"]
