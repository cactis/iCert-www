class CreateCertDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :cert_details do |t|
    	# Course
			t.integer :CLAS_SERIAL
			t.string :CLAS_ID
			t.string :CLAS_NAME
			t.string :CLAS_ENGNAME

			# CourseTemplate

			# CourseSubject


			# User
			t.string :STUD_ID
			t.integer :STUD_NO
			t.string :STUD_NAME
			t.string :STUD_ENGNAME
			t.datetime :BIRTH
			t.string :SEX

			# CourseUser

			# Subject
			t.integer :ITEM_POINT

			# CourseUserSubject
			t.integer :SCORE


			# Cert
			t.string :ITEM_NO
			t.string :ITEM_NAME

			t.decimal :ITEM_POINT
			t.string :MASTER_NO
			t.string :CLS_POINTS
			t.string :ENG_NAME
			t.integer :BUDG_MONTH
			t.integer :BUDG_YEAR
			t.datetime :BUDG_ACTUOPENDATE
			t.string :CLAS_WORD
			t.datetime :CLAS_ENDDATE
			t.integer :SNO
			t.integer :ABS_HOUR
			t.decimal :BUDG_TOTALHOURS
			t.decimal :BUDG_HOURCOUNT
			t.integer :GRP_SNO
			t.string :scls_id
			t.string :MEMO
			t.string :REQUIRED
			t.string :TERM
			t.datetime :OPEN_DATE
			t.datetime :END_DATE
			t.string :OUT_SNO
			t.string :GRAD_SIGN

			t.text :settings
			t.timestamps
    end
  end
end
