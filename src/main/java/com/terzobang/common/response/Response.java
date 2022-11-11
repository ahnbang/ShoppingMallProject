package com.terzobang.common.response;

public class Response <T> {
	
	private final ResponseStatus status;
	private final String message;
	private final T data;


	public Response(ResponseStatus status, String message, T data) {
		super();
		this.status = status;
		this.message = message;
		this.data = data;
	}

	public ResponseStatus getStatus() {
		return status;
	}

	public String getMessage() {
		return message;
	}


	public T getData() {
		return data;
	}

	@Override
	public String toString() {
		return "Response [status=" + status + ", message=" + message + ", data=" + data + "]";
	}
	
	

}
