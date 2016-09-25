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

ActiveRecord::Schema.define(version: 20160925181906) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.datetime "data"
    t.string   "nome"
    t.string   "palestrante"
    t.integer  "event_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "activities", ["event_id"], name: "index_activities_on_event_id", using: :btree

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

  create_table "answer_notes", force: :cascade do |t|
    t.text     "observacao"
    t.integer  "answer_id"
    t.integer  "user_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "arquivo_file_name"
    t.string   "arquivo_content_type"
    t.integer  "arquivo_file_size"
    t.datetime "arquivo_updated_at"
  end

  add_index "answer_notes", ["answer_id"], name: "index_answer_notes_on_answer_id", using: :btree
  add_index "answer_notes", ["user_id"], name: "index_answer_notes_on_user_id", using: :btree

  create_table "answers", force: :cascade do |t|
    t.text     "observacao"
    t.integer  "atividade_extra_id"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.string   "arquivo_resposta_file_name"
    t.string   "arquivo_resposta_content_type"
    t.integer  "arquivo_resposta_file_size"
    t.datetime "arquivo_resposta_updated_at"
    t.integer  "user_id"
    t.string   "status",                        default: "aberta"
  end

  add_index "answers", ["atividade_extra_id"], name: "index_answers_on_atividade_extra_id", using: :btree
  add_index "answers", ["user_id"], name: "index_answers_on_user_id", using: :btree

  create_table "atividade_extras", force: :cascade do |t|
    t.string   "titulo"
    t.text     "descricao"
    t.date     "data_final"
    t.integer  "user_id"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.string   "arquivo_file_name"
    t.string   "arquivo_content_type"
    t.integer  "arquivo_file_size"
    t.datetime "arquivo_updated_at"
    t.string   "arquivo_resposta_file_name"
    t.string   "arquivo_resposta_content_type"
    t.integer  "arquivo_resposta_file_size"
    t.datetime "arquivo_resposta_updated_at"
    t.string   "status",                        default: "aberta"
  end

  add_index "atividade_extras", ["user_id"], name: "index_atividade_extras_on_user_id", using: :btree

  create_table "atividade_extras_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "atividade_extra_id"
  end

  add_index "atividade_extras_users", ["atividade_extra_id"], name: "index_atividade_extras_users_on_atividade_extra_id", using: :btree
  add_index "atividade_extras_users", ["user_id"], name: "index_atividade_extras_users_on_user_id", using: :btree

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

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "nome"
    t.text     "apresentacao"
    t.text     "objetivos"
    t.datetime "inicio"
    t.datetime "fim"
    t.boolean  "submissao"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.string   "normas",       default: "nenhuma"
    t.datetime "deadline",     default: '2016-07-27 18:02:10'
    t.string   "trabalhos",    default: "nenhum"
    t.integer  "user_id"
  end

  add_index "events", ["user_id"], name: "index_events_on_user_id", using: :btree

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

  create_table "learning_quizzes", force: :cascade do |t|
    t.integer  "user_id"
    t.date     "data_final"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "creator_id"
  end

  add_index "learning_quizzes", ["user_id"], name: "index_learning_quizzes_on_user_id", using: :btree

  create_table "learning_quizzes_users", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "learning_quiz_id"
  end

  add_index "learning_quizzes_users", ["learning_quiz_id"], name: "index_learning_quizzes_users_on_learning_quiz_id", using: :btree
  add_index "learning_quizzes_users", ["user_id"], name: "index_learning_quizzes_users_on_user_id", using: :btree

  create_table "learning_results", force: :cascade do |t|
    t.integer  "ec"
    t.integer  "or"
    t.integer  "ca"
    t.integer  "ea"
    t.integer  "user_id"
    t.date     "data_final"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "q1a"
    t.integer  "q1b"
    t.integer  "q1c"
    t.integer  "q1d"
    t.integer  "q2a"
    t.integer  "q2b"
    t.integer  "q2c"
    t.integer  "q2d"
    t.integer  "q3a"
    t.integer  "q3b"
    t.integer  "q3c"
    t.integer  "q3d"
    t.integer  "q4a"
    t.integer  "q4b"
    t.integer  "q4c"
    t.integer  "q4d"
    t.integer  "q5a"
    t.integer  "q5b"
    t.integer  "q5c"
    t.integer  "q5d"
    t.integer  "q6a"
    t.integer  "q6b"
    t.integer  "q6c"
    t.integer  "q6d"
    t.integer  "q7a"
    t.integer  "q7b"
    t.integer  "q7c"
    t.integer  "q7d"
    t.integer  "q8a"
    t.integer  "q8b"
    t.integer  "q8c"
    t.integer  "q8d"
    t.integer  "q9a"
    t.integer  "q9b"
    t.integer  "q9c"
    t.integer  "q9d"
    t.integer  "q10a"
    t.integer  "q10b"
    t.integer  "q10c"
    t.integer  "q10d"
    t.integer  "q11a"
    t.integer  "q11b"
    t.integer  "q11c"
    t.integer  "q11d"
    t.integer  "q12a"
    t.integer  "q12b"
    t.integer  "q12c"
    t.integer  "q12d"
  end

  add_index "learning_results", ["user_id"], name: "index_learning_results_on_user_id", using: :btree

  create_table "learning_styles", force: :cascade do |t|
    t.string   "nome"
    t.text     "descricao"
    t.string   "sigla"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "matriculations", force: :cascade do |t|
    t.string   "nome"
    t.string   "email"
    t.string   "telefone"
    t.string   "tipo"
    t.integer  "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "matriculations", ["event_id"], name: "index_matriculations_on_event_id", using: :btree

  create_table "notes", force: :cascade do |t|
    t.integer "sender_id"
    t.integer "recipient_id"
    t.text    "texto"
    t.string  "topico"
  end

  create_table "objectives", force: :cascade do |t|
    t.string   "deadline"
    t.string   "text"
    t.integer  "plano_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "objectives", ["plano_id"], name: "index_objectives_on_plano_id", using: :btree

  create_table "opportunities", force: :cascade do |t|
    t.string   "text"
    t.integer  "plano_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "opportunities", ["plano_id"], name: "index_opportunities_on_plano_id", using: :btree

  create_table "opportunity_answers", force: :cascade do |t|
    t.string   "text"
    t.integer  "opportunity_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "opportunity_answers", ["opportunity_id"], name: "index_opportunity_answers_on_opportunity_id", using: :btree

  create_table "planos", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.boolean  "publico"
  end

  add_index "planos", ["user_id"], name: "index_planos_on_user_id", using: :btree

  create_table "principals", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string   "titulo"
    t.string   "autor"
    t.string   "email"
    t.text     "resumo"
    t.string   "tags"
    t.string   "tipo"
    t.string   "estado"
    t.integer  "event_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  add_index "projects", ["event_id"], name: "index_projects_on_event_id", using: :btree

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

  create_table "registrations", force: :cascade do |t|
    t.string   "nome"
    t.string   "email"
    t.string   "telefone"
    t.string   "tipo"
    t.integer  "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "registrations", ["event_id"], name: "index_registrations_on_event_id", using: :btree

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

  create_table "strategies", force: :cascade do |t|
    t.date     "deadline"
    t.string   "text"
    t.integer  "objective_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "strategies", ["objective_id"], name: "index_strategies_on_objective_id", using: :btree

  create_table "strength_answers", force: :cascade do |t|
    t.string   "text"
    t.integer  "strength_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "strength_answers", ["strength_id"], name: "index_strength_answers_on_strength_id", using: :btree

  create_table "strengths", force: :cascade do |t|
    t.string   "text"
    t.integer  "plano_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "strengths", ["plano_id"], name: "index_strengths_on_plano_id", using: :btree

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

  create_table "threats", force: :cascade do |t|
    t.string   "text"
    t.integer  "plano_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "threats", ["plano_id"], name: "index_threats_on_plano_id", using: :btree

  create_table "threats_answers", force: :cascade do |t|
    t.string   "text"
    t.integer  "threat_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "threats_answers", ["threat_id"], name: "index_threats_answers_on_threat_id", using: :btree

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

  create_table "videos", force: :cascade do |t|
    t.integer "sender_id"
    t.integer "recipient_id"
    t.string  "url"
    t.string  "description"
    t.integer "user_id"
    t.string  "titulo"
  end

  add_index "videos", ["user_id"], name: "index_videos_on_user_id", using: :btree

  create_table "videos_users", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "video_id"
  end

  add_index "videos_users", ["user_id"], name: "index_videos_users_on_user_id", using: :btree
  add_index "videos_users", ["video_id"], name: "index_videos_users_on_video_id", using: :btree

  create_table "weakness_answers", force: :cascade do |t|
    t.string   "text"
    t.integer  "weakness_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "weakness_answers", ["weakness_id"], name: "index_weakness_answers_on_weakness_id", using: :btree

  create_table "weaknesses", force: :cascade do |t|
    t.string   "text"
    t.integer  "plano_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "weaknesses", ["plano_id"], name: "index_weaknesses_on_plano_id", using: :btree

  add_foreign_key "activities", "events"
  add_foreign_key "anchors", "anchorinfos"
  add_foreign_key "anchors", "results"
  add_foreign_key "answer_notes", "answers"
  add_foreign_key "answer_notes", "users"
  add_foreign_key "answers", "atividade_extras"
  add_foreign_key "answers", "users"
  add_foreign_key "atividade_extras", "users"
  add_foreign_key "atividade_extras_users", "atividade_extras"
  add_foreign_key "atividade_extras_users", "users"
  add_foreign_key "campus", "institutions"
  add_foreign_key "centers", "campus"
  add_foreign_key "classrooms", "subjects"
  add_foreign_key "classrooms_students", "classrooms"
  add_foreign_key "classrooms_students", "students"
  add_foreign_key "classrooms_users", "classrooms"
  add_foreign_key "classrooms_users", "users"
  add_foreign_key "courses", "centers"
  add_foreign_key "events", "users"
  add_foreign_key "learning_quizzes", "users"
  add_foreign_key "learning_quizzes_users", "learning_quizzes"
  add_foreign_key "learning_quizzes_users", "users"
  add_foreign_key "learning_results", "users"
  add_foreign_key "matriculations", "events"
  add_foreign_key "objectives", "planos"
  add_foreign_key "opportunities", "planos"
  add_foreign_key "opportunity_answers", "opportunities"
  add_foreign_key "planos", "users"
  add_foreign_key "projects", "events"
  add_foreign_key "quizzes", "users"
  add_foreign_key "quizzes_users", "quizzes"
  add_foreign_key "quizzes_users", "users"
  add_foreign_key "registrations", "events"
  add_foreign_key "results", "quizzes"
  add_foreign_key "results", "users"
  add_foreign_key "strategies", "objectives"
  add_foreign_key "strength_answers", "strengths"
  add_foreign_key "strengths", "planos"
  add_foreign_key "subjects", "courses"
  add_foreign_key "threats", "planos"
  add_foreign_key "threats_answers", "threats"
  add_foreign_key "users", "courses"
  add_foreign_key "users", "institutions"
  add_foreign_key "videos", "users"
  add_foreign_key "videos_users", "users"
  add_foreign_key "videos_users", "videos"
  add_foreign_key "weakness_answers", "weaknesses"
  add_foreign_key "weaknesses", "planos"
end
