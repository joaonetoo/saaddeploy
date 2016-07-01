# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160701135736) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "administrators", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "anchorinfos", force: :cascade do |t|
    t.string   "nome"
    t.text     "descricao"
    t.text     "perfil"
    t.text     "perspectiva"
    t.string   "tipo"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "anchors", force: :cascade do |t|
    t.string   "nome"
    t.text     "descricao"
    t.text     "perfil"
    t.text     "perspectiva"
    t.string   "tipo"
    t.integer  "result_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "anchorinfo_id"
  end

  add_index "anchors", ["anchorinfo_id"], name: "index_anchors_on_anchorinfo_id", using: :btree
  add_index "anchors", ["result_id"], name: "index_anchors_on_result_id", using: :btree

  create_table "campus", force: :cascade do |t|
    t.string   "name"
    t.integer  "institution_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "campus", ["institution_id"], name: "index_campus_on_institution_id", using: :btree

  create_table "centers", force: :cascade do |t|
    t.string   "name"
    t.integer  "campu_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "centers", ["campu_id"], name: "index_centers_on_campu_id", using: :btree

  create_table "classrooms", force: :cascade do |t|
    t.integer  "subject_id"
    t.string   "turno"
    t.string   "codigo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "classrooms", ["subject_id"], name: "index_classrooms_on_subject_id", using: :btree

  create_table "classrooms_students", id: false, force: :cascade do |t|
    t.integer "student_id"
    t.integer "classroom_id"
  end

  add_index "classrooms_students", ["classroom_id"], name: "index_classrooms_students_on_classroom_id", using: :btree
  add_index "classrooms_students", ["student_id"], name: "index_classrooms_students_on_student_id", using: :btree

  create_table "classrooms_users", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "classroom_id"
  end

  add_index "classrooms_users", ["classroom_id"], name: "index_classrooms_users_on_classroom_id", using: :btree
  add_index "classrooms_users", ["user_id"], name: "index_classrooms_users_on_user_id", using: :btree

  create_table "coordinators", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string   "nome"
    t.date     "data_abertura"
    t.string   "turno"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "center_id"
  end

  add_index "courses", ["center_id"], name: "index_courses_on_center_id", using: :btree

  create_table "institutions", force: :cascade do |t|
    t.string   "cnpj"
    t.string   "logradouro"
    t.string   "numero"
    t.string   "bairro"
    t.string   "cep"
    t.string   "cidade"
    t.string   "estado"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "nome"
    t.string   "tel"
    t.string   "organizacao_academica"
    t.string   "categoria_administrativa"
    t.string   "site"
    t.string   "image_file_name"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "notes", force: :cascade do |t|
    t.integer "sender_id"
    t.integer "recipient_id"
    t.text    "texto"
    t.string  "topico"
  end

  create_table "planos", force: :cascade do |t|
    t.text     "ameacas"
    t.text     "respostas_ameaca"
    t.text     "oportunidades"
    t.text     "respostas_oportunidades"
    t.text     "fraquezas"
    t.text     "respostas_fraquezas"
    t.text     "forcas"
    t.text     "respostas_forcas"
    t.text     "missao"
    t.text     "objetivos_proximo_ano"
    t.text     "objetivos_cinco_anos"
    t.text     "objetivos_dez_anos"
    t.text     "objetivos"
    t.text     "estrategias"
    t.text     "plano_objetivo"
    t.text     "plano_estrategia"
    t.text     "plano_prazo"
    t.text     "plano_fator_critico"
    t.text     "plano_recursos"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "principals", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quizzes", force: :cascade do |t|
    t.integer  "user_id"
    t.date     "data_final"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "creator_id"
  end

  add_index "quizzes", ["user_id"], name: "index_quizzes_on_user_id", using: :btree

  create_table "quizzes_users", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "quiz_id"
  end

  add_index "quizzes_users", ["quiz_id"], name: "index_quizzes_users_on_quiz_id", using: :btree
  add_index "quizzes_users", ["user_id"], name: "index_quizzes_users_on_user_id", using: :btree

  create_table "results", force: :cascade do |t|
    t.date     "data_final"
    t.float    "tf"
    t.float    "gm"
    t.float    "au"
    t.float    "se"
    t.float    "ec"
    t.float    "sv"
    t.float    "ch"
    t.float    "ls"
    t.integer  "quiz_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "results", ["quiz_id"], name: "index_results_on_quiz_id", using: :btree
  add_index "results", ["user_id"], name: "index_results_on_user_id", using: :btree

  create_table "students", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subjects", force: :cascade do |t|
    t.string   "nome"
    t.integer  "ch"
    t.text     "ementa"
    t.string   "codigo"
    t.integer  "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "subjects", ["course_id"], name: "index_subjects_on_course_id", using: :btree

  create_table "teachers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "nome"
    t.string   "telefone"
    t.string   "endereco"
    t.string   "lattes"
    t.text     "biografia"
    t.string   "matricula"
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "type"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.boolean  "approved",               default: false, null: false
    t.integer  "course_id"
    t.integer  "institution_id"
  end

  add_index "users", ["approved"], name: "index_users_on_approved", using: :btree
  add_index "users", ["course_id"], name: "index_users_on_course_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["institution_id"], name: "index_users_on_institution_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "anchors", "anchorinfos"
  add_foreign_key "anchors", "results"
  add_foreign_key "campus", "institutions"
  add_foreign_key "centers", "campus"
  add_foreign_key "classrooms", "subjects"
  add_foreign_key "classrooms_students", "classrooms"
  add_foreign_key "classrooms_students", "students"
  add_foreign_key "classrooms_users", "classrooms"
  add_foreign_key "classrooms_users", "users"
  add_foreign_key "courses", "centers"
  add_foreign_key "quizzes", "users"
  add_foreign_key "quizzes_users", "quizzes"
  add_foreign_key "quizzes_users", "users"
  add_foreign_key "results", "quizzes"
  add_foreign_key "results", "users"
  add_foreign_key "subjects", "courses"
  add_foreign_key "users", "courses"
  add_foreign_key "users", "institutions"
end
