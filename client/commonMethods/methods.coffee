Meteor.methods
	'resetDivs': ()->
		$('.oneAnswerContainer').removeClass('invisible')
		$('.answerTitle').removeClass('invisible')
		# $('.btnAnswer').removeAttr('disabled')
		$('.btnChildAnswer').removeClass('invisible')

	'setupQuestionType1': ()->
		console.log 'setupQuestionType1'
		$('.answerTitle').addClass('invisible')
		$('.oneAnswerContainer').addClass('invisible')
		$('.btnChildAnswer').attr('disabled', true)
		$('#btnNextQuestion').attr('disabled', true)

	'setupQuestionType2': ()->
		console.log 'setupQuestionType2'
		$('.oneAnswerContainer').addClass('invisible')
		$('.btnChildAnswer').attr('disabled', true)
		$('#btnNextQuestion').attr('disabled', true)

	'setupQuestionType3': ()->
		console.log 'setupQuestionType3'
		$('.btnChildAnswer').attr('disabled', true)
		$('#btnNextQuestion').attr('disabled', true)

	'setupQuestionType4': ()->
		console.log 'setupQuestionType4'
		$('.btnChildAnswer').attr('disabled', false)
		$('#btnNextQuestion').addClass('invisible')
		$('#btnNextQuestion').attr('disabled', true)
		$('#timer').addClass('invisible')

	'displayAnswerType1': ()->
		console.log 'displayAnswerType1'
		$('.answerTitle').removeClass('invisible')
		$('.btnChildAnswer').attr('disabled', true)
		$('#btnNextQuestion').attr('disabled', false)

	'displayAnswerType2': ()->
		console.log 'displayAnswerType2'
		$('.oneAnswerContainer').removeClass('invisible')
		$('.btnChildAnswer').attr('disabled', true)
		$('#btnNextQuestion').attr('disabled', false)

	#Fade out wrong answers
	'displayAnswerType3': ()->
		console.log 'displayAnswerType3'
		$('.btnChildAnswer').attr('disabled', true)
		$('.wrongAnswer').addClass('invisible')
		$('#btnNextQuestion').attr('disabled', false)

	'displayAnswerType4': ()->
		$('.btnChildAnswer').removeClass('invisible')
		$('.btnChildAnswer').attr('disabled', false)
		$('.wrongAnswer').removeClass('invisible')


	# Check if answer is correct and increment scores counter
	'countScores': (answerId) ->
		questions = Session.get('questions')
		question = questions[Session.get('counter')]
		for answer in question.answers
			if answer.answerId is answerId
				Session.set('explanation', answer.reason)
				if answer.isCorrectAnswer is YES
					Session.set('isRightAnswer', CORRECT_ANSWER_TEXT)
					n = Session.get('correctAnswersCounter') + 1
					console.log 'Number of correct answers: ' + n
					Session.set('correctAnswersCounter', n)
				else
					Session.set('isRightAnswer', WRONG_ANSWER_TEXT)

		# Time to check what kind of question it is and hide/show divs
	'findQuestionType': ->
		questions = Session.get('questions')
		question = questions[Session.get('counter')]

		len = question.oneAnswerText.length

		Session.set('questionType', QUESTION_TYPE_4)

		# Type 1
		if question.showAnswer is NO
			if question.questionType is SHOW
				if question.oneAnswerText.length == 0
					if question.correctAnswers is ALL
						console.log('questionType is ' + QUESTION_TYPE_1)
						Session.set('questionType', QUESTION_TYPE_1)

		#Type 2
		if question.questionType is SHOW
			if question.oneAnswerText.length > 0
				if question.correctAnswers is ALL
					console.log('questionType is ' + QUESTION_TYPE_2)
					Session.set('questionType', QUESTION_TYPE_2)

		#Type 3
		if question.questionType is SHOW
			if question.showAnswerTimer.length > 0
				if question.correctAnswers is ONE
					console.log('questionType is ' + QUESTION_TYPE_3)
					Session.set('questionType', QUESTION_TYPE_3)

		# #Type 4
	 	if question.questionType is CHOOSE
	 		if question.correctAnswers is ONE
	 			console.log('questionType is ' + QUESTION_TYPE_4)
	 			Session.set('questionType', QUESTION_TYPE_4)	

		if Session.get('questionType') is QUESTION_TYPE_1
			Meteor.call 'setupQuestionType1', () ->
		if Session.get('questionType') is QUESTION_TYPE_2
			Meteor.call 'setupQuestionType2', () ->
		if Session.get('questionType') is QUESTION_TYPE_3
			Meteor.call 'setupQuestionType3', () ->
		if Session.get('questionType') is QUESTION_TYPE_4
			Meteor.call 'setupQuestionType4', () ->

