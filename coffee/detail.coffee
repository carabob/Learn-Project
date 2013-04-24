args = new Object()
detailLoader = (type, id, force) ->
	if type is 'file'
		return
	chrome.extension.sendMessage(
		op : 'detail'
		force : force
		data :
			type : type
			id : id
		(response) ->
			d = response.data
			$('body').addClass response.type
			if response.type is 'notification'
				$('.noti-wrap').show()
				$('.title').text(d.detail.title)
				# use try to filter <script>
				try
					$('.content').html(d.detail.content)
				$('.date').text(new Date(d.day).Format("yyyy-MM-dd"))
				$('.courseName').text(d.courseName)
				$('.author').text(d.author)
			else if response.type is 'deadline'
				$('.ddl-wrap').show()
				$('.title').text(d.detail.title)
				# use try to filter <script>
				try
					$('.content').html(d.detail.content)
				$('.date').text(new Date(d.end).Format("yyyy-MM-dd"))
				$('.courseName').text(d.courseName)
				# use try to filter <script>
				try
					$('.uploadText').html(d.detail.uploadText)
				$('.uploadAttach').html(d.detail.uploadAttach)
				$('.attach').html(d.detail.attach)
			$('.loading').hide()
			if d.state is 'stared'
				$('.action-star').addClass('stared')
	)
init = ->
	args = window.getURLParamters(window.location.href.replace(/#*$/, ''))
	detailLoader(args.type, args.id, false)
	$('.action-refresh').click (e)->
		e.preventDefault()
		update()
update = ->
	$('.loading').show()
	$('.noti-wrap').hide()
	$('.ddl-wrap').hide()
	detailLoader(args.type, args.id, true)
	#star = ->
	#	chrome.extension.sendMessage(
	#		op : 'subState'
	#		data :
	#			type : type
	#			id : id
	#			targetState : target_state
$ ->
	$('.noti-wrap').hide()
	$('.ddl-wrap').hide()
	init()
